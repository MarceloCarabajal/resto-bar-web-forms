<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="resto_bar_web.Error" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container text-center mt-5">
    <h2 class="text-danger">¡Ups! Algo salió mal.</h2>
    <p class="lead">Parece que hubo un problema inesperado en el sistema.</p>
    <hr />
    <a href="Default.aspx" class="btn btn-primary">Volver al Inicio</a>
</div>
</asp:Content>
