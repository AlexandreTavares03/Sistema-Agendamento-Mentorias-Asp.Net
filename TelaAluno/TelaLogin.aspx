<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TelaLogin.aspx.cs" Inherits="TelaAluno.TelaLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Login - Fatec Cruzeiro</title>
    <style>
         body {
         margin: 0;
         font-family: Arial, sans-serif;
         background-color: #f8f8f8;
         color: #465d67;
         }
         .pagina-login {
          padding-top: 96px;
          padding-bottom: 40px;
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
         vertical-align: middle;
         }

         .titulo-cabecalho {
         font-size: 26px;
         font-weight: bold;
         margin-left: 12px;
         vertical-align: middle;
         }

         .card-login {
          padding-top: 80px;
          box-sizing: border-box;
        }

        .conteudo-login {
            width: 100%;
            max-width: 300px;
            background-color: #ffffff;
            border: 1px solid #dde3e6;
            border-radius: 10px;
            padding: 18px;
            box-sizing: border-box;
            margin: 40px auto 0 auto;
        }

        .campo {
            width: 100%;
            padding: 8px;
            margin: 6px 0 14px 0;
            border: 1px solid #c8d1d6;
            box-sizing: border-box;
        }

        .btn {
            width: 100%;
            padding: 10px;
            margin-top: 8px;
            border: 1px solid #465d67;
            cursor: pointer;
            font-weight: bold;
        }

        .btn-aluno {
            background-color: #ad0f0a;
            color: #ffffff;
            border-color: #ad0f0a;
        }

        .btn-coordenador {
            background-color: #ffffff;
            color: #465d67;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="pagina-login">
            <header class="cabecalho">
                 <div class="conteudo-cabecalho">
                    <div>
                        <img class="logo-sistema" src="FATEC.png" alt="Logo do sistema" />
                        <span class="titulo-cabecalho">Olá, seja bem-vindo a página da Fatec Cruzeiro! Faça seu login</span>
                    </div>
                </div>
            </header>

            <main class="card-Login">
                <div class="conteudo-login">
                    <h2>Login</h2>

                    <asp:Label ID="LblUsuario" runat="server" Text="Digite usuário"></asp:Label>
                    <asp:TextBox ID="TxtUsuario" runat="server" CssClass="campo"></asp:TextBox>

                    <asp:Label ID="LblSenha" runat="server" Text="Digite senha"></asp:Label>
                    <asp:TextBox ID="TxtSenha" runat="server" TextMode="Password" CssClass="campo"></asp:TextBox>
                    
                    <asp:Button ID="BtnLoginAluno" runat="server" Text="Entrar Aluno" CssClass="btn btn-aluno" OnClick="BtnLoginAluno_Click"/>
                    <asp:Button ID="BtnLoginCoordenador" runat="server" Text="Entrar Coordenador" CssClass="btn btn-coordenador" OnClick="BtnLoginCoordenador_Click"/>
                    <br />

                    <asp:Label ID="LblMensagem" runat="server" Text="Usuário ou senha inválidos." Visible="false"></asp:Label>
                </div>

            </main>
        </div>
    </form>
</body>
</html>
