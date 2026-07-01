<%@ Page Title="Reportes" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Reportes.aspx.cs" Inherits="resto_bar_web.Reportes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="mb-4">
        <h1 class="h2">Reportes</h1>
        <p class="text-secondary mb-0">Pedidos cerrados del dia por mesa y por mesero.</p>
    </section>
    <asp:Panel ID="pnlMensaje" runat="server" Visible="false" CssClass="alert alert-danger">
        <asp:Literal ID="litMensaje" runat="server" />
    </asp:Panel>
    <div class="card mb-4">
        <div class="card-body">
            <div class="row g-3 align-items-end">
                <div class="col-md-4">
                    <label for="<%= txtFecha.ClientID %>" class="form-label">Fecha</label>
                    <asp:TextBox ID="txtFecha" runat="server" CssClass="form-control" TextMode="Date" />
                </div>
                <div class="col-md-4">
                    <asp:Button ID="btnConsultar" runat="server" Text="Consultar" CssClass="btn btn-primary" OnClick="btnConsultar_Click" />
                </div>
            </div>
        </div>
    </div>
    <h2 class="h5 mb-3">Por mesa</h2>
    <asp:GridView ID="dgvPorMesa" runat="server" CssClass="table table-striped table-bordered align-middle mb-4" AutoGenerateColumns="False" EmptyDataText="No hay pedidos cerrados para esta fecha.">
        <Columns>
            <asp:BoundField DataField="NumeroMesa" HeaderText="Mesa" />
            <asp:BoundField DataField="CantidadPedidos" HeaderText="Cantidad pedidos" />
            <asp:TemplateField HeaderText="Total vendido">
                <ItemTemplate>
                    <%# string.Format("{0:C}", Eval("TotalVendido")) %>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <h2 class="h5 mb-3">Por mesero</h2>
    <asp:GridView ID="dgvPorMesero" runat="server" CssClass="table table-striped table-bordered align-middle" AutoGenerateColumns="False" EmptyDataText="No hay pedidos cerrados para esta fecha.">
        <Columns>
            <asp:BoundField DataField="Mesero" HeaderText="Mesero" />
            <asp:BoundField DataField="CantidadPedidos" HeaderText="Cantidad pedidos" />
            <asp:TemplateField HeaderText="Total vendido">
                <ItemTemplate>
                    <%# string.Format("{0:C}", Eval("TotalVendido")) %>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>