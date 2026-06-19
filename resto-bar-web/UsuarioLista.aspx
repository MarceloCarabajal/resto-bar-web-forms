<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="UsuarioLista.aspx.cs" Inherits="resto_bar_web.UsuarioLista" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Listado de Usuarios</h2>
    <hr />

    <asp:GridView ID="dgvUsuarios" runat="server" CssClass="table table-striped" AutoGenerateColumns="false" OnRowCommand="dgvUsuarios_RowCommand" >
     <Columns>
         <asp:BoundField HeaderText="Id" DataField="Id" />
        <asp:BoundField HeaderText="UserName" DataField="UserName" />
        <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
        <asp:BoundField HeaderText="Apellido" DataField="Apellido" />
        
       
        <asp:TemplateField HeaderText="Acciones">
            <ItemTemplate>
            <asp:Button ID="btnEditar" runat="server" Text="Editar" 
            CommandArgument='<%#Eval("Id")%>'
            CommandName="Modificar" CssClass="btn btn-primary btn-sm" />
           
            <asp:Button ID="btnInactivar" runat="server" Text="Inactivar" 
            CommandArgument='<%#Eval("Id")%>' 
            CommandName="Inactivar" CssClass="btn btn-danger btn-sm" />
                
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
        
    </asp:GridView>
    <a href="UsuarioForm.aspx" class="btn btn-primary">Agregar Usuario</a>

</asp:Content>
