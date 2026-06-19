<%@ Page Title="Insumos" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="InsumosLista.aspx.cs" Inherits="resto_bar_web.InsumosLista" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="mb-4">
        <h1 class="h2">Insumos</h1>
        <p class="text-secondary mb-0">Administracion de platos y bebidas del catalogo.</p>
    </section>

    <asp:Panel ID="pnlMensaje" runat="server" Visible="false" CssClass="alert alert-danger">
        <asp:Literal ID="litMensaje" runat="server" />
    </asp:Panel>

    <div class="mb-3">
        <a class="btn btn-primary" href="InsumoForm.aspx">Agregar insumo</a>
    </div>

    <asp:GridView ID="dgvInsumos" runat="server" CssClass="table table-striped table-bordered align-middle" AutoGenerateColumns="False" OnRowCommand="dgvInsumos_RowCommand" DataKeyNames="Id">
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="Id" />
            <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
            <asp:TemplateField HeaderText="Tipo">
                <ItemTemplate>
                    <%# Eval("Tipo.Nombre") %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Precio" HeaderText="Precio" DataFormatString="{0:C2}" />
            <asp:BoundField DataField="CantidadStock" HeaderText="Stock" />
            <asp:TemplateField HeaderText="Estado">
                <ItemTemplate>
                    <%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Acciones">
                <ItemTemplate>
                    <a class="btn btn-sm btn-outline-primary me-2" href='<%# "InsumoForm.aspx?id=" + Eval("Id") %>'>Editar</a>
                    <asp:LinkButton ID="btnInactivar" runat="server" CssClass="btn btn-sm btn-outline-danger" CommandName="InactivarInsumo" CommandArgument='<%# Eval("Id") %>' Visible='<%# (bool)Eval("Activo") %>' OnClientClick="return confirm('Seguro que queres inactivar este insumo?');">Inactivar</asp:LinkButton>
                    <asp:LinkButton ID="btnActivar" runat="server" CssClass="btn btn-sm btn-outline-success" CommandName="ActivarInsumo" CommandArgument='<%# Eval("Id") %>' Visible='<%# !(bool)Eval("Activo") %>' OnClientClick="return confirm('Seguro que queres activar este insumo?');">Activar</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
