<%@ Page Title="Login" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="resto_bar_web.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="mb-4">
        <h1 class="h2">Login</h1>
        <p class="text-secondary mb-0">Ingreso de usuarios del sistema.</p>
    </section>

    <div class="row">
        <div class="col-md-6 col-lg-4">
            <div class="mb-3">
                <label for="txtUsuario" class="form-label">Usuario</label>
                <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control" />
            </div>
            <div class="mb-3">
                <label for="txtClave" class="form-label">Clave</label>
                <asp:TextBox ID="txtClave" runat="server" CssClass="form-control" TextMode="Password" />
            </div>
            <asp:Button ID="btnIngresar" runat="server" Text="Ingresar" CssClass="btn btn-primary" Enabled="false" />
        </div>
    </div>
</asp:Content>
