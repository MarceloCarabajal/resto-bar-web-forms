<%@ Page Title="Asignacion de mesas" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="MesasAsignacion.aspx.cs" Inherits="resto_bar_web.MesasAsignacion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="mb-4">
        <h1 class="h2">Asignacion de mesas</h1>
        <p class="text-secondary mb-0">Asignar meseros a las mesas activas del resto.</p>
    </section>

    <asp:Panel ID="pnlMensaje" runat="server" Visible="false" CssClass="alert alert-danger">
        <asp:Literal ID="litMensaje" runat="server" />
    </asp:Panel>

    <asp:Panel ID="pnlExito" runat="server" Visible="false" CssClass="alert alert-success">
        <asp:Literal ID="litExito" runat="server" />
    </asp:Panel>

    <div class="card mb-4">
        <div class="card-body">
            <div class="row g-3 align-items-end">
                <div class="col-md-4">
                    <label for="<%= ddlMesa.ClientID %>" class="form-label">Mesa</label>
                    <asp:DropDownList ID="ddlMesa" runat="server" CssClass="form-select" />
                    <asp:RequiredFieldValidator ID="rfvMesa" runat="server" ControlToValidate="ddlMesa" InitialValue="0" CssClass="text-danger" ErrorMessage="Debe seleccionar una mesa." Display="Dynamic" ValidationGroup="vgAsignar" />
                </div>
                <div class="col-md-4">
                    <label for="<%= ddlMesero.ClientID %>" class="form-label">Mesero</label>
                    <asp:DropDownList ID="ddlMesero" runat="server" CssClass="form-select" />
                    <asp:RequiredFieldValidator ID="rfvMesero" runat="server" ControlToValidate="ddlMesero" InitialValue="0" CssClass="text-danger" ErrorMessage="Debe seleccionar un mesero." Display="Dynamic" ValidationGroup="vgAsignar" />
                </div>
                <div class="col-md-4">
                    <asp:Button ID="btnAsignar" runat="server" Text="Asignar" CssClass="btn btn-primary" OnClick="btnAsignar_Click" ValidationGroup="vgAsignar" />
                </div>
            </div>
        </div>
    </div>

    <h2 class="h5 mb-3">Mesas asignadas</h2>
    <asp:GridView ID="dgvAsignadas" runat="server" CssClass="table table-striped table-bordered align-middle" AutoGenerateColumns="False" EmptyDataText="No hay mesas con asignacion vigente.">
        <Columns>
            <asp:BoundField DataField="Numero" HeaderText="Mesa" />
            <asp:BoundField DataField="Mesero" HeaderText="Mesero" />
            <asp:BoundField DataField="EstadoMesa" HeaderText="Estado" />
        </Columns>
    </asp:GridView>
</asp:Content>
