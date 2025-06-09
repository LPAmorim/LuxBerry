// sessão
function validarSessao() {
    // sessionStorage  permite armazenar dados temporariamente no navegador, somente enquanto a aba ou janela estiver aberta. 
    //eu salvo temporariamente os dados de email e nome do meu usuario para validar a sessão dele 
    var email = sessionStorage.EMAIL_USUARIO;
    var nome = sessionStorage.NOME_USUARIO;
    console.log(email)

    if (email == null && nome == null) {
        window.location = "../login.html";
        return
    }
}

function validarHeaderDash() {
    var nome = sessionStorage.NOME_USUARIO;

    var cargo = sessionStorage.CARGO_USUARIO.toLowerCase();
    console.log(cargo)

    if (cargo == "suporten3") {
        headerDash = document.getElementById("header")
        headerDash.innerHTML = `
        <img src="../assets/LuxBerry.png" alt=""></a>
        <div>
            <p>Usuario: <span class="user-logado" id="user_logado">${nome}</span></p>
        </div>
      <div>
            <a href="#" onclick="limparSessao()" style="color: red;">Sair</a>
      </div>
        `;
    } else {
        headerDash = document.getElementById("header")
        headerDash.innerHTML = `
        <img src="../assets/LuxBerry.png" alt=""></a>
        <div>
            <p>Usuario: <span class="user-logado" id="user_logado">${nome}</span></p>
        </div>
      <div>
            <a href="alerta.html">Visão Geral</a>
        <a href="dashboard.html">Dashboard</a>
            <a href="notificacoes-dash.html">Histórico</a>
            <a href="../cadastro.html">Cadastre um funcionário</a>
            <a href="https://luxberrymonitoramento.atlassian.net/servicedesk/customer/portal/1"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><rect width="24" height="24" fill="none"/><g fill="none" stroke="#fff" stroke-width="1.5"><path stroke-linecap="round" stroke-linejoin="round" d="M4.5 18h-.75a3 3 0 0 1-3-3v-3a3 3 0 0 1 3-3h.75a.75.75 0 0 1 .75.75v7.5a.75.75 0 0 1-.75.75m15.75 0h-.75a.75.75 0 0 1-.75-.75v-7.5A.75.75 0 0 1 19.5 9h.75a3 3 0 0 1 3 3v3a3 3 0 0 1-3 3M3.75 9a8.25 8.25 0 1 1 16.5 0M15 21.75h2.25a3 3 0 0 0 3-3V18"/><path stroke-linecap="round" stroke-linejoin="round" d="M13.5 23.25H12a1.5 1.5 0 1 1 0-3h1.5a1.5 1.5 0 1 1 0 3M9 8.25a3 3 0 0 1 5.753-1.192c.218.505.294 1.06.218 1.605A3 3 0 0 1 13 11.079a1.5 1.5 0 0 0-1 1.415v.256"/><path d="M12 16.5a.375.375 0 0 1 0-.75m0 .75a.375.375 0 0 0 0-.75"/></g></svg></a>
            <a href="#" onclick="limparSessao()" style="color: red;">Sair</a>
                  </div>
        `;
    }
}

function limparSessao() {
    //limpo os dados do usuario logado
    sessionStorage.clear();
    window.location = "../login.html";
}

// carregamento (loading)
function aguardar() {
    var divAguardar = document.getElementById("div_aguardar");
    divAguardar.style.display = "flex";
}

function finalizarAguardar(texto) {
    var divAguardar = document.getElementById("div_aguardar");
    divAguardar.style.display = "none";

    var divErrosLogin = document.getElementById("div_erros_login");
    if (texto) {
        divErrosLogin.style.display = "flex";
        divErrosLogin.innerHTML = texto;
    }
}

