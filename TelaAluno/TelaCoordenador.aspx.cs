using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TelaAluno
{
    public partial class TelaCoordenador : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void DdlTipoAluno_SelectedIndexChanged(object sender, EventArgs e)
        {
            PnlDadosMentor.Visible = (DdlTipoAluno.SelectedValue == "Mentor");
        }

        protected void BtnSalvarCadastro_Click(object sender, EventArgs e)
        {
            string nome = TxtNomeAluno.Text.Trim();
            string matricula = TxtMatricula.Text.Trim();
            string curso = TxtCurso.Text.Trim();
            string periodoTexto = TxtPeriodo.Text.Trim();
            string email = TxtUsuario.Text.Trim();
            string senha = TxtSenha.Text.Trim();
            string ehMentor = DdlTipoAluno.SelectedValue == "Mentor" ? "S" : "N";

            if (nome == "" || matricula == "" || curso == "" || periodoTexto == "" || email == "" || senha == "")
            {
                LblMensagem.Text = "Preencha nome, matrícula, curso, período, e-mail e senha.";
                LblMensagem.Visible = true;
                return;
            }

            string[] listaDisciplinas = new string[0];
            string[] listaHorarios = new string[0];
            DateTime dataDisp = DateTime.MinValue;

            if (ehMentor == "S")
            {
                if (TxtDisciplinas.Text.Trim() == "" || TxtDataDisponivel.Text.Trim() == "" || !TxtHorarioDisponivel.Text.Contains("-"))
                {
                    LblMensagem.Text = "Para mentor, informe disciplinas, data e horário (ex.: 14:00 - 16:00).";
                    LblMensagem.Visible = true;
                    return;
                }

                dataDisp = DateTime.Parse(TxtDataDisponivel.Text.Trim());
                listaDisciplinas = TxtDisciplinas.Text.Trim().Split(',');
                listaHorarios = TxtHorarioDisponivel.Text.Trim().Split(',');

                foreach (string h in listaHorarios)
                {
                    if (!string.IsNullOrWhiteSpace(h) && !h.Contains("-"))
                    {
                        LblMensagem.Text = "Informe os horários separados por '-' (ex.: 14:00 - 16:00, 18:00 - 20:00).";
                        LblMensagem.Visible = true;
                        return;
                    }
                }
            }

            int periodo = int.Parse(periodoTexto);
            string strConexao = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection conexao = new SqlConnection(strConexao))
            {
                conexao.Open();

                // 1. Cria o usuário e já pega o id_usuario gerado
                string sqlUsuario = @"INSERT INTO Usuario (email, senha)
                                      VALUES (@email, @senha);
                                      SELECT SCOPE_IDENTITY();";

                SqlCommand cmdUsuario = new SqlCommand(sqlUsuario, conexao);
                cmdUsuario.Parameters.AddWithValue("@email", email);
                cmdUsuario.Parameters.AddWithValue("@senha", senha);

                int idUsuario = Convert.ToInt32(cmdUsuario.ExecuteScalar());

                // 2. Cria o aluno ligado a esse id_usuario e pega o id_aluno gerado
                string sqlAluno = @"INSERT INTO Aluno (id_usuario, matricula, mentor, nome)
                                    VALUES (@idUsuario, @matricula, @mentor, @nome);
                                    SELECT SCOPE_IDENTITY();";

                SqlCommand cmdAluno = new SqlCommand(sqlAluno, conexao);
                cmdAluno.Parameters.AddWithValue("@idUsuario", idUsuario);
                cmdAluno.Parameters.AddWithValue("@matricula", matricula);
                cmdAluno.Parameters.AddWithValue("@mentor", ehMentor);
                cmdAluno.Parameters.AddWithValue("@nome", nome);

                int idAluno = Convert.ToInt32(cmdAluno.ExecuteScalar());

                // 3. Busca ou cadastra o curso e vincula em Aluno_Curso
                string sqlBuscaCurso = "SELECT id_curso FROM Curso WHERE nome = @nomeCurso AND periodo = @periodo";
                SqlCommand cmdBuscaCurso = new SqlCommand(sqlBuscaCurso, conexao);
                cmdBuscaCurso.Parameters.AddWithValue("@nomeCurso", curso);
                cmdBuscaCurso.Parameters.AddWithValue("@periodo", periodo);

                object objCurso = cmdBuscaCurso.ExecuteScalar();
                int idCurso;

                if (objCurso != null)
                {
                    idCurso = Convert.ToInt32(objCurso);
                }
                else
                {
                    string sqlInsereCurso = @"INSERT INTO Curso (nome, periodo)
                                              VALUES (@nomeCurso, @periodo);
                                              SELECT SCOPE_IDENTITY();";
                    SqlCommand cmdInsereCurso = new SqlCommand(sqlInsereCurso, conexao);
                    cmdInsereCurso.Parameters.AddWithValue("@nomeCurso", curso);
                    cmdInsereCurso.Parameters.AddWithValue("@periodo", periodo);
                    idCurso = Convert.ToInt32(cmdInsereCurso.ExecuteScalar());
                }

                string sqlAlunoCurso = "INSERT INTO Aluno_Curso (id_aluno, id_curso) VALUES (@idAluno, @idCurso)";
                SqlCommand cmdAlunoCurso = new SqlCommand(sqlAlunoCurso, conexao);
                cmdAlunoCurso.Parameters.AddWithValue("@idAluno", idAluno);
                cmdAlunoCurso.Parameters.AddWithValue("@idCurso", idCurso);
                cmdAlunoCurso.ExecuteNonQuery();

                // 4. Se for mentor, salva disciplinas e disponibilidades para a data selecionada
                if (ehMentor == "S")
                {
                    for (int i = 0; i < listaDisciplinas.Length; i++)
                    {
                        string nomeDisciplina = listaDisciplinas[i].Trim();
                        if (string.IsNullOrWhiteSpace(nomeDisciplina)) continue;

                        string sqlBuscaDisc = "SELECT id_disciplina FROM Disciplina WHERE nome = @nomeDisc";
                        SqlCommand cmdBuscaDisc = new SqlCommand(sqlBuscaDisc, conexao);
                        cmdBuscaDisc.Parameters.AddWithValue("@nomeDisc", nomeDisciplina);

                        object objDisc = cmdBuscaDisc.ExecuteScalar();
                        int idDisciplina;

                        if (objDisc != null)
                        {
                            idDisciplina = Convert.ToInt32(objDisc);
                        }
                        else
                        {
                            string sqlInsereDisc = @"INSERT INTO Disciplina (nome)
                                                     VALUES (@nomeDisc);
                                                     SELECT SCOPE_IDENTITY();";
                            SqlCommand cmdInsereDisc = new SqlCommand(sqlInsereDisc, conexao);
                            cmdInsereDisc.Parameters.AddWithValue("@nomeDisc", nomeDisciplina);
                            idDisciplina = Convert.ToInt32(cmdInsereDisc.ExecuteScalar());

                            string sqlCursoDisc = "INSERT INTO Curso_Disciplina (id_curso, id_disciplina) VALUES (@idCurso, @idDisciplina)";
                            SqlCommand cmdCursoDisc = new SqlCommand(sqlCursoDisc, conexao);
                            cmdCursoDisc.Parameters.AddWithValue("@idCurso", idCurso);
                            cmdCursoDisc.Parameters.AddWithValue("@idDisciplina", idDisciplina);
                            cmdCursoDisc.ExecuteNonQuery();
                        }

                        string sqlMentorDisc = "INSERT INTO mentor_disciplina (id_aluno, id_disciplina) VALUES (@idAluno, @idDisciplina)";
                        SqlCommand cmdMentorDisc = new SqlCommand(sqlMentorDisc, conexao);
                        cmdMentorDisc.Parameters.AddWithValue("@idAluno", idAluno);
                        cmdMentorDisc.Parameters.AddWithValue("@idDisciplina", idDisciplina);
                        cmdMentorDisc.ExecuteNonQuery();

                        string textoHorario = (i < listaHorarios.Length && !string.IsNullOrWhiteSpace(listaHorarios[i]))
                            ? listaHorarios[i].Trim()
                            : listaHorarios[listaHorarios.Length - 1].Trim();

                        string[] partesHorario = textoHorario.Split('-');
                        TimeSpan horaInicio = TimeSpan.Parse(partesHorario[0].Trim());
                        TimeSpan horaFinal = TimeSpan.Parse(partesHorario[1].Trim());

                        string sqlDisp = @"INSERT INTO Disponibilidade (dt_disponibilidade, hora_inicio, hora_final, id_aluno)
                                           VALUES (@dataDisp, @horaInicio, @horaFinal, @idAluno)";
                        SqlCommand cmdDisp = new SqlCommand(sqlDisp, conexao);
                        cmdDisp.Parameters.AddWithValue("@dataDisp", dataDisp.Date);
                        cmdDisp.Parameters.AddWithValue("@horaInicio", horaInicio);
                        cmdDisp.Parameters.AddWithValue("@horaFinal", horaFinal);
                        cmdDisp.Parameters.AddWithValue("@idAluno", idAluno);
                        cmdDisp.ExecuteNonQuery();
                    }
                }
            }

            TxtNomeAluno.Text = "";
            TxtMatricula.Text = "";
            TxtCurso.Text = "";
            TxtPeriodo.Text = "";
            TxtUsuario.Text = "";
            TxtSenha.Text = "";
            TxtDisciplinas.Text = "";
            TxtDataDisponivel.Text = "";
            TxtHorarioDisponivel.Text = "";
            DdlTipoAluno.SelectedIndex = 0;
            PnlDadosMentor.Visible = false;

            LblMensagem.Text = "Cadastro salvo com sucesso!";
            LblMensagem.Visible = true;
        }

        protected void BtnSair_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("TelaLogin.aspx");
        }
    }
}