<%@ Page Title="Mesas" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="MesasLista.aspx.cs" Inherits="resto_bar_web.MesasLista" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="mb-4">
        <h1 class="h2">Mesas</h1>
        <p class="text-secondary mb-0">Administracion de mesas del resto.</p>
    </section>

    <asp:Panel ID="pnlMensaje" runat="server" Visible="false" CssClass="alert alert-danger">
        <asp:Literal ID="litMensaje" runat="server" />
    </asp:Panel>

    <div class="mb-3">
        <a class="btn btn-primary" href="MesaForm.aspx">Agregar mesa</a>
    </div>

    <asp:GridView ID="dgvMesas" runat="server" CssClass="table table-striped table-bordered align-middle" AutoGenerateColumns="False" OnRowCommand="dgvMesas_RowCommand" DataKeyNames="Id">
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="Id" />
            <asp:BoundField DataField="Numero" HeaderText="Numero" />
            <asp:TemplateField HeaderText="Estado">
                <ItemTemplate>
                    <%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Acciones">
                <ItemTemplate>
                    <a class="btn btn-sm btn-outline-primary me-2" href='<%# "MesaForm.aspx?id=" + Eval("Id") %>'>Editar</a>
                    <asp:LinkButton ID="btnInactivar" runat="server" CssClass="btn btn-sm btn-outline-danger" CommandName="InactivarMesa" CommandArgument='<%# Eval("Id") %>' Visible='<%# (bool)Eval("Activo") %>' data-confirm-message="Seguro que queres inactivar esta mesa?">Inactivar</asp:LinkButton>
                    <asp:LinkButton ID="btnActivar" runat="server" CssClass="btn btn-sm btn-outline-success" CommandName="ActivarMesa" CommandArgument='<%# Eval("Id") %>' Visible='<%# !(bool)Eval("Activo") %>' data-confirm-message="Seguro que queres activar esta mesa?">Activar</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
