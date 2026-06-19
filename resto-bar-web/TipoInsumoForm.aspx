<%@ Page Title="Tipo de insumo" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="TipoInsumoForm.aspx.cs" Inherits="resto_bar_web.TipoInsumoForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="mb-4">
        <h1 class="h2">
            <asp:Literal ID="litTitulo" runat="server" />
        </h1>
        <p class="text-secondary mb-0">Carga y edicion de tipos para clasificar insumos.</p>
    </section>

    <asp:Panel ID="pnlMensaje" runat="server" Visible="false" CssClass="alert alert-danger">
        <asp:Literal ID="litMensaje" runat="server" />
    </asp:Panel>

    <div class="mb-3">
        <label for="<%= txtNombre.ClientID %>" class="form-label">Nombre</label>
        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" MaxLength="50" />
        <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre" CssClass="text-danger" ErrorMessage="El nombre es obligatorio." Display="Dynamic" />
    </div>

    <div class="d-flex gap-2">
        <asp:Button ID="btnGuardar" runat="server" CssClass="btn btn-primary" Text="Guardar" OnClick="btnGuardar_Click" />
        <a class="btn btn-outline-secondary" href="TiposInsumoLista.aspx">Cancelar</a>
    </div>
</asp:Content>
