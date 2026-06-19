<%@ Page Title="Insumo" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="InsumoForm.aspx.cs" Inherits="resto_bar_web.InsumoForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="mb-4">
        <h1 class="h2">
            <asp:Literal ID="litTitulo" runat="server" />
        </h1>
        <p class="text-secondary mb-0">Carga y edicion de platos y bebidas.</p>
    </section>

    <asp:Panel ID="pnlMensaje" runat="server" Visible="false" CssClass="alert alert-danger">
        <asp:Literal ID="litMensaje" runat="server" />
    </asp:Panel>

    <div class="mb-3">
        <label for="<%= txtNombre.ClientID %>" class="form-label">Nombre</label>
        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" MaxLength="100" />
        <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre" CssClass="text-danger" ErrorMessage="El nombre es obligatorio." Display="Dynamic" />
    </div>

    <div class="mb-3">
        <label for="<%= ddlTipo.ClientID %>" class="form-label">Tipo</label>
        <asp:DropDownList ID="ddlTipo" runat="server" CssClass="form-select" />
        <asp:RequiredFieldValidator ID="rfvTipo" runat="server" ControlToValidate="ddlTipo" InitialValue="" CssClass="text-danger" ErrorMessage="Seleccione un tipo." Display="Dynamic" />
    </div>

    <div class="mb-3">
        <label for="<%= txtPrecio.ClientID %>" class="form-label">Precio</label>
        <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control" />
        <asp:RequiredFieldValidator ID="rfvPrecio" runat="server" ControlToValidate="txtPrecio" CssClass="text-danger" ErrorMessage="El precio es obligatorio." Display="Dynamic" />
        <asp:RangeValidator ID="rvPrecio" runat="server" ControlToValidate="txtPrecio" Type="Double" MinimumValue="0" MaximumValue="999999999" CssClass="text-danger" ErrorMessage="El precio debe ser mayor o igual a cero." Display="Dynamic" />
    </div>

    <div class="mb-3">
        <label for="<%= txtStock.ClientID %>" class="form-label">Stock</label>
        <asp:TextBox ID="txtStock" runat="server" CssClass="form-control" />
        <asp:RequiredFieldValidator ID="rfvStock" runat="server" ControlToValidate="txtStock" CssClass="text-danger" ErrorMessage="El stock es obligatorio." Display="Dynamic" />
        <asp:RangeValidator ID="rvStock" runat="server" ControlToValidate="txtStock" Type="Integer" MinimumValue="0" MaximumValue="999999999" CssClass="text-danger" ErrorMessage="El stock debe ser mayor o igual a cero." Display="Dynamic" />
    </div>

    <div class="d-flex gap-2">
        <asp:Button ID="btnGuardar" runat="server" CssClass="btn btn-primary" Text="Guardar" OnClick="btnGuardar_Click" />
        <a class="btn btn-outline-secondary" href="InsumosLista.aspx">Cancelar</a>
    </div>
</asp:Content>
