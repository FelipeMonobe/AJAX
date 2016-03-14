<%@ Page Title="WEB - Cadastro AJAX" Language="C#" MasterPageFile="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/bootstrap.css" rel="stylesheet" />
    <link href="css/bootstrap-theme.min.css" rel="stylesheet" />
    <link href="css/bootstrap-theme.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="divForm" class="divFormulario" style="width: 250px; margin-left: 550px">

        <h3 class="titulo">CADASTRO AJAX</h3>
        <br />
        <br />

        <asp:ScriptManager ID="scriptmng1" runat="server">
            <Services>
                <asp:ServiceReference Path="~/wbsvc.asmx" />
            </Services>
        </asp:ScriptManager>

        <div id="divFormulario">
            <div id="divExcluir" style="display: none">
                <label>ID: </label>
                <br />
                <input type="text" class="form-control" id="txtID" value="" /><br />
            </div>
            <div id="divInserir">
                <label>Username: </label>
                <br />
                <input type="text" class="form-control" id="txtUsername" value="" /><br />
                <label>Nome: </label>
                <br />
                <input type="text" class="form-control" id="txtNome" value="" /><br />

                <label>Idade: </label>
                <br />
                <input type="text" class="form-control" id="txtIdade" value="" /><br />

                <label>Foto: </label>
                <br />
                <input type="text" class="form-control" id="txtUpload" value="" /><br />
                <label>Upload: </label>
                <br />
                <input type="file" id="uploadFile" /><br />
            </div>
        </div>

        <span id="Campo"></span>

        <input type="button" class="btn btn-primary" id="btnExibir" value="Exibir" onclick="a()" />
        <input type="button" class="btn btn-success" id="btnInserir" value="Inserir" onclick="b()" />
        <input type="button" class="btn btn-danger" id="btnDeletar" value="Deletar" onclick="c()" />
        <br />

        <script type="text/javascript">
            "use strict"

            var campo = document.getElementById("Campo"), formulario = document.getElementById("divFormulario"),
                txtnome = document.getElementById("txtNome"), txtuser = document.getElementById("txtUsername"),
                txtidade = document.getElementById("txtIdade"), txtupload = document.getElementById("txtUpload"),
                inserir = document.getElementById("divInserir"), excluir = document.getElementById("divExcluir"),
                    id = document.getElementById("txtID"), file = document.getElementById("uploadFile"),
                    arquivo = new FormData();

            function a() {
                if (campo.style.display == "none") {
                    campo.style.display = "initial";
                }
                ServicoBD.wbsvc.Buscar(Resposta);
                formulario.style.display = "none";
            }

            function Resposta(resultado) {
                campo.innerHTML = resultado;
            }

            function b() {
                if (inserir.style.display == "none" || formulario.style.display == "none") {
                    formulario.style.display = "initial";
                    inserir.style.display = "initial";
                    excluir.style.display = "none";
                    campo.style.display = "none";
                }
                else {
                    if (txtuser.value !== "") {

                        arquivo.append("upload", file.files[0]);

                        ServicoBD.wbsvc.Inserir(txtuser.value,
                            txtnome.value,
                            parseInt(txtidade.value),
                            txtupload.value,
                            alert("Dados inseridos com sucesso!"));
                    }
                    else {
                        alert("ERRO!!! inserção vazia!");
                    }
                }
                limpaCampos();
            }

            function c() {
                if (excluir.style.display == "none" || formulario.style.display == "none") {
                    formulario.style.display = "initial";
                    excluir.style.display = "initial";
                    inserir.style.display = "none";
                    campo.style.display = "none";
                }
                else {
                    if (id.value !== "") {
                        ServicoBD.wbsvc.Deletar(parseInt(id.value),
                            alert("Dados deletados com sucesso!"));
                    }
                    else {
                        alert("ERRO!!! deleção vazia!");
                    }
                }
                limpaCampos();
            }

            function limpaCampos() {
                id.value = "";
                txtuser.value = "";
                txtnome.value = "";
                txtidade.value = "";
                txtupload.value = "";
            }

        </script>
    </div>
</asp:Content>


