using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;
using System.Data;
using System.Data.SqlClient;
using System.IO;

namespace ServicoBD
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]

    [ScriptService]
    public class wbsvc : System.Web.Services.WebService
    {
        SqlConnection conn = new SqlConnection(@"Data Source=.\SQLEXPRESS; Initial Catalog=AJAX; Trusted_Connection=Yes");

        [WebMethod]
        public string Buscar()
        {
            conn.Open();

            SqlCommand cmd = new SqlCommand("SELECT * FROM USUARIO", conn);
            SqlDataReader reader = cmd.ExecuteReader();

            string saida = "";
            List<UsuarioSQL> listaUsuarios = new List<UsuarioSQL>();

            while (reader.Read())
            {
                UsuarioSQL usuario = new UsuarioSQL();
                usuario.idusuario = reader[0].ToString();
                usuario.username = reader[1].ToString();
                usuario.nomeusuario = reader[2].ToString();
                usuario.idadeusuario = reader[3].ToString();
                usuario.fotousuario = reader[4].ToString();
                listaUsuarios.Add(usuario);
            }

            foreach (UsuarioSQL item in listaUsuarios)
            {
                saida += "<img src=\"/Ajax/imagens/" + item.fotousuario +
                    "\" width=\"125px\" height=\"125px\" />" +
                    "<br><strong>ID:</strong> " + item.idusuario +
                    "<br><strong>Username:</strong> " + item.username +
                    "<br><strong>Nome:</strong> " + item.nomeusuario +
                    "<br><strong>Idade:</strong> " + item.idadeusuario + "<br><br>";
            }

            cmd.Dispose();
            reader.Close();
            reader.Dispose();
            conn.Close();
            conn.Dispose();

            return saida;
        }

        [WebMethod]
        public void Inserir(string username, string nome, int idade, string foto)
        {
            conn.Open();

            SqlCommand cmd = new SqlCommand("INSERT INTO USUARIO VALUES(@username, @nome, @idade, @foto)", conn);
            cmd.Parameters.Add("@username", SqlDbType.VarChar).Value = username;
            cmd.Parameters.Add("@nome", SqlDbType.VarChar).Value = nome;
            cmd.Parameters.Add("@idade", SqlDbType.Int).Value = idade;
            cmd.Parameters.Add("@foto", SqlDbType.VarChar).Value = foto;

            cmd.ExecuteNonQuery();
            cmd.Dispose();
            conn.Close();
            conn.Dispose();
        }

        [WebMethod]
        public void Deletar(int id)
        {
            conn.Open();

            SqlCommand cmd = new SqlCommand("DELETE FROM USUARIO WHERE ID = @id", conn);
            cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;
            cmd.Parameters[0].Value = id;

            cmd.ExecuteNonQuery();
            cmd.Dispose();
            conn.Close();
            conn.Dispose();
        }

        public class UsuarioSQL
        {
            internal string idusuario, fotousuario, idadeusuario, nomeusuario, username;

            public UsuarioSQL()
            {
            }
        }
    }
}