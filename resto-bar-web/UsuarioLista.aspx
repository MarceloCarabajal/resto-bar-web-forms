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
           
            <asp:LinkButton ID="btnEstado" runat="server" 
             CommandName='<%# (bool)Eval("Activo") ? "Inactivar" : "Activar" %>' 
             CommandArgument='<%# Eval("Id") %>'
             Text='<%# (bool)Eval("Activo") ? "Inactivar" : "Activar" %>'
             CssClass='<%# (bool)Eval("Activo") ? "btn btn-sm btn-outline-danger" : "btn btn-sm btn-outline-success" %>'
             OnClientClick='<%# (bool)Eval("Activo") ? "return confirm(\"¿Desea inactivar este usuario?\");" : "return confirm(\"¿Desea activar este usuario?\");" %>'>
         </asp:LinkButton>
            

          </ItemTemplate>
        </asp:TemplateField>
    </Columns>
  </asp:GridView>

</asp:Content>
