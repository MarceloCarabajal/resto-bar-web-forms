<%@ Page Title="Inicio" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="resto_bar_web.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   
    <section class="mb-4">
        <h1 class="h2">Panel inicial</h1>
        <p class="text-secondary mb-0">Gestion de mesas, pedidos, insumos y reportes del restaurante.</p>
    </section>

    <div class="row g-3">
        <div class="col-md-6 col-lg-3">
            <div class="card h-100">
                <div class="card-body d-flex flex-column">
                    <h2 class="h5">Insumos</h2>
                    <p class="text-secondary">Consulta del catalogo de platos y bebidas.</p>
                    <a class="btn btn-outline-primary mt-auto" href="InsumosLista.aspx">Ver insumos</a>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-3">
            <div class="card h-100">
                <div class="card-body d-flex flex-column">
                    <h2 class="h5">Mesas/Pedidos</h2>
                    <p class="text-secondary">Acceso preparado para la gestion operativa.</p>
                    <a class="btn btn-outline-primary mt-auto" href="MesasPedidos.aspx">Ir a mesas</a>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-3">
            <div class="card h-100">
                <div class="card-body d-flex flex-column">
                    <h2 class="h5">Reportes</h2>
                    <p class="text-secondary">Seccion reservada para el cierre diario.</p>
                    <a class="btn btn-outline-primary mt-auto" href="Reportes.aspx">Ver reportes</a>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-3">
            <div class="card h-100">
                <div class="card-body d-flex flex-column">
                    <h2 class="h5">Login</h2>
                    <p class="text-secondary">Pantalla inicial para el futuro acceso de usuarios.</p>
                    <a class="btn btn-outline-primary mt-auto" href="Login.aspx">Ingresar</a>
                </div>
            </div>
        </div>
    
        </div>
</asp:Content>
