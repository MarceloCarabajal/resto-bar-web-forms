<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="UsuarioLista.aspx.cs" Inherits="resto_bar_web.UsuarioLista" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class= "container mt-4"></div>
    <h2>Usuarios</h2>
     <p>Administración de los usuarios del sistema.</p>

    <div class ="mb-3">
        <a href="UsuarioForm.aspx" class="btn btn-primary">Agregar Usuario</a>
     </div>

    <asp:GridView ID="dgvUsuarios" runat="server" DataKeyNames="Id" ShowHeaderWhenEmpty="true" EnableViewState="true" CssClass="table table-striped"
        AutoGenerateColumns="false" OnRowCommand="dgvUsuarios_RowCommand" EmptyDataText="No hay usuarios registrados." >
     <Columns>
        
         <asp:BoundField HeaderText="Id" DataField="Id" />
        <asp:BoundField HeaderText="UserName" DataField="UserName" />
        <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
        <asp:BoundField HeaderText="Apellido" DataField="Apellido" />

    <asp:TemplateField HeaderText="Rol">
    <ItemTemplate>
        <asp:Label Text='<%# Eval("Rol.Nombre") %>' runat="server" />
    </ItemTemplate>
    </asp:TemplateField>
       
      <asp:TemplateField HeaderText="Estado">
        <ItemTemplate>
        <asp:Label runat="server" 
         Text='<%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>'>
        </asp:Label>
        </ItemTemplate>
      </asp:TemplateField>
       
        <asp:TemplateField HeaderText="Acciones">
            <ItemTemplate>
            <a class="btn btn-sm btn-outline-primary me-2" href='UsuarioForm.aspx?id=<%# Eval("Id") %>'>Editar</a>
           
            <asp:LinkButton ID="btnInactivar" runat="server" CssClass="btn btn-sm btn-outline-danger" CommandName="Inactivar" CommandArgument='<%# Eval("Id") %>' Visible='<%# (bool)Eval("Activo") %>' data-confirm-message="¿Desea inactivar este usuario?">Inactivar</asp:LinkButton>
            <asp:LinkButton ID="btnActivar" runat="server" CssClass="btn btn-sm btn-outline-success" CommandName="Activar" CommandArgument='<%# Eval("Id") %>' Visible='<%# !(bool)Eval("Activo") %>' data-confirm-message="¿Desea activar este usuario?">Activar</asp:LinkButton>
            

          </ItemTemplate>
        </asp:TemplateField>
    </Columns>
  </asp:GridView>

</asp:Content>
