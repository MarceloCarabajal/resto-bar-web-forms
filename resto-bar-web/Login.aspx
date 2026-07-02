<%@ Page Title="Login" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="resto_bar_web.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="mb-4">
        <h1 class="h2">Login</h1>
        <p class="text-secondary mb-0">Ingreso de usuarios del sistema.</p>
    </section>

    <div class="row">
        <div class="col-md-6 col-lg-4">
            <div class="mb-3">
                <label for="txtUsuario" class="form-label">Usuario</label>
                <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control" />
            
              <asp:RequiredFieldValidator ID="rfvUsuario" runat="server" 
              ControlToValidate="txtUsuario" 
              ErrorMessage ="El usuario es obligatorio" 
              ForeColor="Red" Display="Dynamic" />
           </div>
            <div class="mb-3">
                <label for="txtClave" class="form-label">Clave</label>
                <asp:TextBox ID="txtClave" runat="server" CssClass="form-control" TextMode="Password" />
    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
    ControlToValidate="txtClave" 
    ErrorMessage="La contraseña es obligatoria" 
    ForeColor="Red" Display="Dynamic" />
      </div>
     <asp:Button ID="btnIngresar" runat="server" Text="Ingresar" CssClass="btn btn-primary" OnClick="btnIngresar_Click" CausesValidation="true" UseSubmitBehavior="false"  />
        <div class="mt-3">
       <asp:Label ID="lblMensaje" runat="server" Text="" ForeColor="Red" />
       </div>
      </div>
    </div>
</asp:Content>
