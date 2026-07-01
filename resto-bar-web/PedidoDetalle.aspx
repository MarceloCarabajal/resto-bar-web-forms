<%@ Page Title="Pedido" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="PedidoDetalle.aspx.cs" Inherits="resto_bar_web.PedidoDetalle" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="mb-4">
        <h1 class="h2">
            <asp:Literal ID="litTitulo" runat="server" />
        </h1>
        <p class="text-secondary mb-0">
            <asp:Literal ID="litResumen" runat="server" />
        </p>
    </section>

    <asp:Panel ID="pnlMensaje" runat="server" Visible="false" CssClass="alert alert-danger">
        <asp:Literal ID="litMensaje" runat="server" />
    </asp:Panel>

    <asp:Panel ID="pnlExito" runat="server" Visible="false" CssClass="alert alert-success">
        <asp:Literal ID="litExito" runat="server" />
    </asp:Panel>

    <asp:Panel ID="pnlCargaItem" runat="server" CssClass="card mb-4">
        <div class="card-body">
            <div class="row g-3 align-items-end">
                <div class="col-md-6">
                    <label for="<%= ddlInsumo.ClientID %>" class="form-label">Insumo</label>
                    <asp:DropDownList ID="ddlInsumo" runat="server" CssClass="form-select" />
                    <asp:RequiredFieldValidator ID="rfvInsumo" runat="server" ControlToValidate="ddlInsumo" InitialValue="0" CssClass="text-danger" ErrorMessage="Debe seleccionar un insumo." Display="Dynamic" ValidationGroup="vgItem" />
                </div>
                <div class="col-md-3">
                    <label for="<%= txtCantidad.ClientID %>" class="form-label">Cantidad</label>
                    <asp:TextBox ID="txtCantidad" runat="server" CssClass="form-control" />
                    <asp:RequiredFieldValidator ID="rfvCantidad" runat="server" ControlToValidate="txtCantidad" CssClass="text-danger" ErrorMessage="La cantidad es obligatoria." Display="Dynamic" ValidationGroup="vgItem" />
                    <asp:RangeValidator ID="rvCantidad" runat="server" ControlToValidate="txtCantidad" Type="Integer" MinimumValue="1" MaximumValue="999999" CssClass="text-danger" ErrorMessage="La cantidad debe ser mayor a cero." Display="Dynamic" ValidationGroup="vgItem" />
                </div>
                <div class="col-md-3">
                    <asp:Button ID="btnAgregar" runat="server" Text="Agregar item" CssClass="btn btn-primary" OnClick="btnAgregar_Click" ValidationGroup="vgItem" />
                </div>
            </div>
        </div>
    </asp:Panel>

    <asp:GridView ID="dgvDetalle" runat="server" CssClass="table table-striped table-bordered align-middle" AutoGenerateColumns="False" EmptyDataText="El pedido no tiene items cargados." OnRowCommand="dgvDetalle_RowCommand">
        <Columns>
            <asp:BoundField DataField="Insumo.Nombre" HeaderText="Insumo" />
            <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />
            <asp:BoundField DataField="PrecioUnitario" HeaderText="Precio unitario" DataFormatString="{0:C}" />
            <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" DataFormatString="{0:C}" />
            <asp:TemplateField HeaderText="Acciones">
                <ItemTemplate>
                    <asp:LinkButton ID="btnEliminarItem" runat="server" CssClass="btn btn-sm btn-outline-danger" Text="Eliminar"
                        CommandName="EliminarItem" CommandArgument='<%# Eval("Id") %>' CausesValidation="false"
                        data-confirm-message="Seguro que queres eliminar este item del pedido?" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <div class="d-flex justify-content-between align-items-center mt-3">
        <a class="btn btn-outline-secondary" href="MesasPedidos.aspx">Volver</a>
        <div class="d-flex gap-2 align-items-center">
            <strong>Total: <asp:Literal ID="litTotal" runat="server" /></strong>
            <asp:Button ID="btnCerrar" runat="server" Text="Cerrar pedido" CssClass="btn btn-success" OnClick="btnCerrar_Click" CausesValidation="false" data-confirm-message="Seguro que queres cerrar este pedido?" />
        </div>
    </div>
</asp:Content>
