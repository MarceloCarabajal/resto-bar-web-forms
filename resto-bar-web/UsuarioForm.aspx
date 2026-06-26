<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="UsuarioForm.aspx.cs" Inherits="resto_bar_web.UsuarioForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Nuevo Usuario</h2>
    
    <label>Rol:</label>
<asp:DropDownList ID="ddlRol" runat="server" CssClass="form-control">
</asp:DropDownList>
<asp:RequiredFieldValidator ID="rfvRol" runat="server" ControlToValidate="ddlRol" InitialValue="0" 
    ErrorMessage="Debe seleccionar un rol." ForeColor="Red" Display="Dynamic" ValidationGroup="vgUsuario"/>


    <asp:HiddenField ID="hfIdUsuario" runat="server" Value="0" />
    <div class="mb-3">
        <label>Usuario:</label>
        <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control" />
        <asp:RequiredFieldValidator ID="rfvUserName" runat="server" ControlToValidate="txtUserName" 
        ErrorMessage="El nombre de usuario es obligatorio" ForeColor="Red" Display="Dynamic" ValidationGroup="vgUsuario" />
    </div>
    <div class="mb-3">
        <label>Clave:</label>
        <asp:TextBox ID="txtClave" runat="server" TextMode="Password" CssClass="form-control" />
        <asp:RequiredFieldValidator ID="rfvClave" runat="server" ControlToValidate="txtClave" 
        ErrorMessage="La clave es obligatoria" ForeColor="Red" Display="Dynamic" ValidationGroup="vgUsuario" />
    </div>
    <div class="mb-3">
        <label>Nombre:</label>
        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" />
        <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre" 
        ErrorMessage="El nombre es obligatorio" ForeColor="Red" Display="Dynamic" ValidationGroup="vgUsuario" />
    </div>
    <div class="mb-3">
        <label>Apellido:</label>
        <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" />
        <asp:RequiredFieldValidator ID="rfvApellido" runat="server" ControlToValidate="txtApellido" 
        ErrorMessage="El apellido es obligatorio" ForeColor="Red" Display="Dynamic" ValidationGroup="vgUsuario" />
       </div>

    <asp:Label ID="lblMensaje" runat="server" ForeColor="Red" />
    <asp:Button ID="btnGuardar" runat="server" Text="Guardar" OnClick="btnGuardar_Click" CssClass="btn btn-primary" ValidationGroup="vgUsuario" />
    <asp:Button ID="btnCancelar" runat="server" Text="Cancelar"  CssClass="btn btn-secondary" OnClick="btnCancelar_Click" CausesValidation="false" />
    

</asp:Content>
