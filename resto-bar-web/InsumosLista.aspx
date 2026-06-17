<%@ Page Title="Insumos" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="InsumosLista.aspx.cs" Inherits="resto_bar_web.InsumosLista" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="mb-4">
        <h1 class="h2">Insumos</h1>
        <p class="text-secondary mb-0">Catalogo de platos y bebidas (lectura desde base de datos).</p>
    </section>
    <asp:GridView ID="dgvInsumos" runat="server" CssClass="table table-striped table-bordered" AutoGenerateColumns="False">
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="Id" />
            <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
            <asp:TemplateField HeaderText="Tipo">
                <ItemTemplate>
                    <%# Eval("Tipo.Nombre") %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Precio" HeaderText="Precio" />
            <asp:BoundField DataField="CantidadStock" HeaderText="Stock" />
        </Columns>
    </asp:GridView>
</asp:Content>
