<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TelaCoordenador.aspx.cs" Inherits="TelaAluno.TelaCoordenador" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Coordenação - Fatec Cruzeiro</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
            color: #465d67;
            padding-top: 96px;
        }

        .cabecalho {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            background-color: #ffffff;
            border-bottom: 1px solid #dde3e6;
            padding: 12px 24px;
            box-sizing: border-box;
            z-index: 100;
        }

        .conteudo-cabecalho {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo-sistema {
            height: 48px;
        }

        .titulo-cabecalho {
            font-size: 26px;
            font-weight: bold;
            margin-left: 12px;
        }

        .btnSair {
            background-color: #ad0f0a;
            color: #ffffff;
            border: none;
            border-radius: 6px;
            padding: 10px 18px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
        }

        .card {
            max-width: 780px;
            margin: 0 auto;
            background-color: #ffffff;
            border: 1px solid #dde3e6;
            border-radius: 8px;
            padding: 18px;
            margin-bottom: 18px;
            box-sizing: border-box;  
        }

        .campo {
            width: 100%;
            padding: 8px;
            margin-top: 4px;
            border: 1px solid #c8d1d6;
            border-radius: 6px;
            box-sizing: border-box;
        }

        .bloco-mentor {
            background-color: #f8f8f8;
            border: 1px solid #dde3e6;
            border-radius: 6px;
            padding: 12px;
            margin-top: 12px;
        }

        .btn {
            width: 100%;
            padding: 10px;
            margin-top: 14px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            background-color: #ad0f0a;
            color: #ffffff;
        }

        .msg {
            display: block;
            margin-top: 10px;
            font-size: 13px;
            font-weight: bold;
        }

        .grid {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        .grid th,
        .grid td {
            border: 1px solid #dde3e6;
            padding: 8px;
            text-align: left;
            font-size: 13px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <header class="cabecalho">
            <div class="conteudo-cabecalho">
                <div>
                    <img class="logo-sistema" src="FATEC.png" alt="Logo do sistema" />
                    <span class="titulo-cabecalho">Área da Coordenação</span>
                </div>
                <asp:Button ID="BtnSair" runat="server" Text="Sair" CssClass="btnSair" OnClick="BtnSair_Click" />
            </div>
        </header>

            <section class="card">
                <h2>Cadastrar Aluno ou Mentor</h2>

                <asp:Label ID="LblNomeAluno" runat="server" Text="Nome do aluno" ></asp:Label>
                <asp:TextBox ID="TxtNomeAluno" runat="server" CssClass="campo"></asp:TextBox>

                <asp:Label ID="LblMatricula" runat="server" Text="Matrícula"></asp:Label>
                <asp:TextBox ID="TxtMatricula" runat="server" CssClass="campo"></asp:TextBox>

                <asp:Label ID="LblCurso" runat="server" Text="Curso"></asp:Label>
                <asp:TextBox ID="TxtCurso" runat="server" CssClass="campo"></asp:TextBox>

                <asp:Label ID="LblPeriodo" runat="server" Text="Período"></asp:Label>
                <asp:TextBox ID="TxtPeriodo" runat="server" CssClass="campo"></asp:TextBox>

                <asp:Label ID="LblUsuario" runat="server" Text="Usuário (informe E-mail institucional)"></asp:Label>
                <asp:TextBox ID="TxtUsuario" runat="server" CssClass="campo"></asp:TextBox>

                <asp:Label ID="LblSenha" runat="server" Text="Senha"></asp:Label>
                <asp:TextBox ID="TxtSenha" runat="server" CssClass="campo" TextMode="Password"></asp:TextBox>

                <asp:Label ID="LblTipoAluno" runat="server" Text="Tipo de aluno"></asp:Label>
                <asp:DropDownList ID="DdlTipoAluno" runat="server" CssClass="campo" AutoPostBack="true" OnSelectedIndexChanged="DdlTipoAluno_SelectedIndexChanged">
                    <asp:ListItem Text="Aluno Comum" Value="Comum" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="Aluno Mentor" Value="Mentor"></asp:ListItem>
                </asp:DropDownList>

                <asp:Panel ID="PnlDadosMentor" runat="server" CssClass="bloco-mentor" Visible="false">
                    <strong>Dados do Aluno Mentor</strong>
                    <br /><br />

                    <asp:Label ID="LblDisciplinas" runat="server" Text="Disciplinas de mentoria"></asp:Label>
                    <asp:TextBox ID="TxtDisciplinas" runat="server" CssClass="campo"></asp:TextBox>

                    <asp:Label ID="LblDataDisponivel" runat="server" Text="Data disponível"></asp:Label>
                    <asp:TextBox ID="TxtDataDisponivel" runat="server" CssClass="campo" TextMode="Date"></asp:TextBox>

                    <asp:Label ID="LblHorarioDisponivel" runat="server" Text="Horário disponível"></asp:Label>
                    <asp:TextBox ID="TxtHorarioDisponivel" runat="server" CssClass="campo"></asp:TextBox>
                </asp:Panel>

                <asp:Button ID="BtnSalvarCadastro" runat="server" Text="Salvar Cadastro" CssClass="btn" OnClick="BtnSalvarCadastro_Click" />
                <asp:Label ID="LblMensagem" runat="server" CssClass="msg"></asp:Label>
            </section>

            <section class="card">
                <h2>Mentorias Agendadas</h2>

                <asp:GridView ID="GvMentoriasAgendadas" runat="server" CssClass="grid" AutoGenerateColumns="true" EmptyDataText="Nenhuma mentoria agendada até o momento.">
                </asp:GridView>
            </section>
    </form>
</body>
</html>
