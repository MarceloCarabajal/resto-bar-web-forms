<%@ Page Title="Mesas y pedidos" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="MesasPedidos.aspx.cs" Inherits="resto_bar_web.MesasPedidos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="mb-4">
        <h1 class="h2">Mesas y pedidos</h1>
        <p class="text-secondary mb-0">Abrir, consultar y cerrar pedidos por mesa asignada.</p>
    </section>

    <asp:Panel ID="pnlMensaje" runat="server" Visible="false" CssClass="alert alert-danger">
        <asp:Literal ID="litMensaje" runat="server" />
    </asp:Panel>

    <asp:GridView ID="dgvMesas" runat="server" CssClass="table table-striped table-bordered align-middle" AutoGenerateColumns="False" EmptyDataText="No hay mesas asignadas."
        OnRowCommand="dgvMesas_RowCommand">
        <Columns>
            <asp:BoundField DataField="Numero" HeaderText="Mesa" />
            <asp:BoundField DataField="Mesero" HeaderText="Mesero" />
            <asp:BoundField DataField="EstadoMesa" HeaderText="Estado" />
            <asp:TemplateField HeaderText="Pedido">
                <ItemTemplate>
                    <asp:LinkButton ID="btnAbrir" runat="server" CssClass="btn btn-sm btn-primary" Text="Abrir pedido"
                        CommandName="AbrirPedido" CommandArgument='<%# Eval("Id") + "|" + Eval("IdMesero") %>'
                        Visible='<%# Eval("IdPedidoAbierto") == null %>' />
                    <a class="btn btn-sm btn-outline-primary" href='<%# "PedidoDetalle.aspx?id=" + Eval("IdPedidoAbierto") %>'
                        visible='<%# Eval("IdPedidoAbierto") != null %>' runat="server">Ver pedido</a>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
