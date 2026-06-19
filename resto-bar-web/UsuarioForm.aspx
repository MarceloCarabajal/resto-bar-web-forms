<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="UsuarioForm.aspx.cs" Inherits="resto_bar_web.UsuarioForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Nuevo Usuario</h2>
    
    <div class="mb-3">
        <label>Usuario:</label>
        <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control" />
    </div>
    <div class="mb-3">
        <label>Clave:</label>
        <asp:TextBox ID="txtClave" runat="server" TextMode="Password" CssClass="form-control" />
    </div>
    <div class="mb-3">
        <label>Nombre:</label>
        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" />
    </div>
    <div class="mb-3">
        <label>Apellido:</label>
        <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" />
    </div>

    <asp:Label ID="lblMensaje" runat="server" ForeColor="Red" />
    <asp:Button ID="btnGuardar" runat="server" Text="Guardar" OnClick="btnGuardar_Click" CssClass="btn btn-primary" />
    
    

</asp:Content>
