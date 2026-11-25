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
    public partial class TelaLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void BtnLoginAluno_Click(object sender, EventArgs e)
        {
            string usuario = TxtUsuario.Text.Trim();
            string senha = TxtSenha.Text.Trim();

            // Aqui você pode adicionar a lógica de autenticação do aluno
            if (usuario == "" && senha == "")
            {
                LblMensagem.Text = "Preencha usuário (e-mail institucional) e senha.";
                LblMensagem.Visible = true;
                return;
            }

            string strConexao = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            SqlConnection conexao = new SqlConnection(strConexao);
            using (SqlConnection Conexao = new SqlConnection(strConexao))
            {
                conexao.Open();

                string sqlUsuario = "SELECT id_usuario FROM Usuario WHERE email = @email AND senha = @senha";
                SqlCommand cmdUsuario = new SqlCommand(sqlUsuario, conexao);
                cmdUsuario.Parameters.AddWithValue("@email", usuario);
                cmdUsuario.Parameters.AddWithValue("@senha", senha);

                object idUsuario = cmdUsuario.ExecuteScalar();

                if (idUsuario == null)
                {
                    conexao.Close();
                    LblMensagem.Text = "E-mail ou senha incorretos.";
                    LblMensagem.Visible = true;
                    return;
                }

                string sqlAluno = "SELECT id_aluno, matricula, mentor, nome FROM Aluno WHERE id_usuario = @id_usuario";

                using (SqlCommand cmdAluno = new SqlCommand(sqlAluno, conexao))
                {
                    cmdAluno.Parameters.AddWithValue("@id_usuario", Convert.ToInt32(idUsuario));

                    using (SqlDataReader reader = cmdAluno.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            Session["UsuarioId"] = Convert.ToInt32(idUsuario);
                            Session["AlunoId"] = reader["id_aluno"];
                            Session["Matricula"] = reader["matricula"].ToString();
                            Session["Mentor"] = reader["mentor"].ToString();
                            Session["NomeAluno"] = reader["nome"].ToString();

                            Response.Redirect("TelaAluno.aspx", false);
                            Context.ApplicationInstance.CompleteRequest();
                            return;
                        }

                        else
                        {
                            LblMensagem.Text = "Usuário ou senha inválidos.";
                            LblMensagem.Visible = true;
                        }
                    }
                }
            }
        }
     

        protected void BtnLoginCoordenador_Click(object sender, EventArgs e)
        {
            string usuario = TxtUsuario.Text.Trim();
            string senha = TxtSenha.Text.Trim();
            // a lógica de autenticação do coordenador
            if (usuario == "" && senha == "") {

                LblMensagem.Text = "Digite e-mail e senha para entrar.";
                LblMensagem.Visible = true;
                return;
            }
            string strConexao = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            SqlConnection conexao = new SqlConnection(strConexao);
            conexao.Open();

            string sqlUsuario = "SELECT id_usuario FROM Usuario WHERE email = @email AND senha = @senha";
            SqlCommand cmdUsuario = new SqlCommand(sqlUsuario, conexao);
            cmdUsuario.Parameters.AddWithValue("@email", usuario);
            cmdUsuario.Parameters.AddWithValue("@senha", senha);

            object idUsuario = cmdUsuario.ExecuteScalar();
        
           if (idUsuario == null)
            {
                conexao.Close();
                LblMensagem.Text = "E-mail ou senha incorretos.";
                LblMensagem.Visible = true;
                return;
            }

            // 3. Confere se esse id_usuario está na tabela Coordenacao
            string sqlCoord = "SELECT COUNT(*) FROM Coordenacao WHERE id_usuario = @id";
            SqlCommand cmdCoord = new SqlCommand(sqlCoord, conexao);
            cmdCoord.Parameters.AddWithValue("@id", idUsuario);

            int qtdCoord = (int)cmdCoord.ExecuteScalar();
            conexao.Close();

            // 4. Se achou (maior que 0), entra na tela do coordenador
            if (qtdCoord > 0)
            {
                Session["IdUsuario"] = idUsuario;
                Response.Redirect("TelaCoordenador.aspx");
            }
            else
            {
             LblMensagem.Text = "Você não é coordenador.";
             LblMensagem.Visible = true;
            }
        }
        
    }
}