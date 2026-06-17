<%@ Page Title="Tipos de insumo" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="TiposInsumoLista.aspx.cs" Inherits="resto_bar_web.TiposInsumoLista" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="mb-4">
        <h1 class="h2">Tipos de insumo</h1>
        <p class="text-secondary mb-0">Administracion de categorias para platos y bebidas.</p>
    </section>

    <asp:Panel ID="pnlMensaje" runat="server" Visible="false" CssClass="alert alert-danger">
        <asp:Literal ID="litMensaje" runat="server" />
    </asp:Panel>

    <div class="mb-3">
        <a class="btn btn-primary" href="TipoInsumoForm.aspx">Agregar tipo</a>
    </div>

    <asp:GridView ID="dgvTiposInsumo" runat="server" CssClass="table table-striped table-bordered align-middle" AutoGenerateColumns="False" OnRowCommand="dgvTiposInsumo_RowCommand" DataKeyNames="Id">
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="Id" />
            <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
            <asp:TemplateField HeaderText="Estado">
                <ItemTemplate>
                    <%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Acciones">
                <ItemTemplate>
                    <a class="btn btn-sm btn-outline-primary me-2" href='<%# "TipoInsumoForm.aspx?id=" + Eval("Id") %>'>Editar</a>
                    <asp:LinkButton ID="btnInactivar" runat="server" CssClass="btn btn-sm btn-outline-danger" CommandName="InactivarTipo" CommandArgument='<%# Eval("Id") %>' Visible='<%# (bool)Eval("Activo") %>' OnClientClick="return confirm('Seguro que queres inactivar este tipo de insumo?');">Inactivar</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
