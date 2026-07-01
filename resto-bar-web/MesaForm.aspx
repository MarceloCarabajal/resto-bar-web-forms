<%@ Page Title="Mesa" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="MesaForm.aspx.cs" Inherits="resto_bar_web.MesaForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="mb-4">
        <h1 class="h2">
            <asp:Literal ID="litTitulo" runat="server" />
        </h1>
        <p class="text-secondary mb-0">Carga y edicion de mesas del resto.</p>
    </section>

    <asp:Panel ID="pnlMensaje" runat="server" Visible="false" CssClass="alert alert-danger">
        <asp:Literal ID="litMensaje" runat="server" />
    </asp:Panel>

    <div class="mb-3">
        <label for="<%= txtNumero.ClientID %>" class="form-label">Numero</label>
        <asp:TextBox ID="txtNumero" runat="server" CssClass="form-control" />
        <asp:RequiredFieldValidator ID="rfvNumero" runat="server" ControlToValidate="txtNumero" CssClass="text-danger" ErrorMessage="El numero es obligatorio." Display="Dynamic" />
        <asp:RangeValidator ID="rvNumero" runat="server" ControlToValidate="txtNumero" Type="Integer" MinimumValue="1" MaximumValue="9999" CssClass="text-danger" ErrorMessage="El numero debe estar entre 1 y 9999." Display="Dynamic" />
    </div>

    <div class="d-flex gap-2">
        <asp:Button ID="btnGuardar" runat="server" CssClass="btn btn-primary" Text="Guardar" OnClick="btnGuardar_Click" />
        <a class="btn btn-outline-secondary" href="MesasLista.aspx">Cancelar</a>
    </div>
</asp:Content>
