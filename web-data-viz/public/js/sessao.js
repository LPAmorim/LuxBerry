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

    var cargo = sessionStorage.CARGO_USUARIO;
    console.log(cargo)

    if (cargo == "SuporteN3") {
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
            <a href="suporte.html">Suporte</a>
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
            <a href="https://luxberrymonitoramento.atlassian.net/servicedesk/customer/portal/1">FQA</a>
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

