
function obterdados(fkEmp) {
    fetch(`/alertas/buscarAlertas/${fkEmp}`)
        .then(resposta => {
            if (resposta.status == 200) {
                resposta.json().then(resposta => {

                    console.log(`Dados recebidos: ${JSON.stringify(resposta)}`);
                    alertar(resposta)
                });
            } else {
                console.error(`Nenhum dado encontrado para o id ${idAquario} ou erro na API`);
            }
        })
        .catch(function (error) {
            console.error(`Erro na obtenção dos dados do aquario p/ gráfico: ${error.message}`);
        });

}

var alertaID = null;
function alertar(resposta) {
    for (let i = 0; i < resposta.length; i++) {
        alertaID = resposta[0].idalerta
        if (alertaID != sessionStorage.alertaId) {
            dashboard = document.getElementById("alertas")
            dashboard.innerHTML += `
                <div class="alerta" id="card_alerta${i}" onclick="fechar(${i})">
                    <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" viewBox="0 0 24 24"><rect width="24" height="24" fill="none"/><path fill="red" d="M2.725 21q-.275 0-.5-.137t-.35-.363t-.137-.488t.137-.512l9.25-16q.15-.25.388-.375T12 3t.488.125t.387.375l9.25 16q.15.25.138.513t-.138.487t-.35.363t-.5.137zM12 18q.425 0 .713-.288T13 17t-.288-.712T12 16t-.712.288T11 17t.288.713T12 18m0-3q.425 0 .713-.288T13 14v-3q0-.425-.288-.712T12 10t-.712.288T11 11v3q0 .425.288.713T12 15"/></svg>
                    <div>
                    <p>Alerta para a ${resposta[0].nome} - sensor ${resposta[0].fksensor}</p>
                    <p>${resposta[0].tipo_alerta}</p>
                    <p>${resposta[0].data_hora}</p>
                    </div>
                </div>
                `
            sessionStorage.alertaId = alertaID
        }
    }
}

function fechar(id) {
    cardAlerta = document.getElementById(`card_alerta${id}`)
    cardAlerta.style.display = "none"
}

// function alertar(resposta, idAquario) {
//     var temp = resposta[0].temperatura;

//     var grauDeAviso = '';

//     var limites = {
//         muito_quente: 23,
//         quente: 22,
//         ideal: 20,
//         frio: 10,
//         muito_frio: 5
//     };

//     var classe_temperatura = 'cor-alerta';

//     if (temp >= limites.muito_quente) {
//         classe_temperatura = 'cor-alerta perigo-quente';
//         grauDeAviso = 'perigo quente'
//         grauDeAvisoCor = 'cor-alerta perigo-quente'
//         exibirAlerta(temp, idAquario, grauDeAviso, grauDeAvisoCor)
//     }
//     else if (temp < limites.muito_quente && temp >= limites.quente) {
//         classe_temperatura = 'cor-alerta alerta-quente';
//         grauDeAviso = 'alerta quente'
//         grauDeAvisoCor = 'cor-alerta alerta-quente'
//         exibirAlerta(temp, idAquario, grauDeAviso, grauDeAvisoCor)
//     }
//     else if (temp < limites.quente && temp > limites.frio) {
//         classe_temperatura = 'cor-alerta ideal';
//         removerAlerta(idAquario);
//     }
//     else if (temp <= limites.frio && temp > limites.muito_frio) {
//         classe_temperatura = 'cor-alerta alerta-frio';
//         grauDeAviso = 'alerta frio'
//         grauDeAvisoCor = 'cor-alerta alerta-frio'
//         exibirAlerta(temp, idAquario, grauDeAviso, grauDeAvisoCor)
//     }
//     else if (temp <= limites.muito_frio) {
//         classe_temperatura = 'cor-alerta perigo-frio';
//         grauDeAviso = 'perigo frio'
//         grauDeAvisoCor = 'cor-alerta perigo-frio'
//         exibirAlerta(temp, idAquario, grauDeAviso, grauDeAvisoCor)
//     }

//     var card;

//     if (document.getElementById(`temp_aquario_${idAquario}`) != null) {
//         document.getElementById(`temp_aquario_${idAquario}`).innerHTML = temp + "°C";
//     }

//     if (document.getElementById(`card_${idAquario}`)) {
//         card = document.getElementById(`card_${idAquario}`)
//         card.className = classe_temperatura;
//     }
// }

// function exibirAlerta(temp, idAquario, grauDeAviso, grauDeAvisoCor) {
//     var indice = alertas.findIndex(item => item.idAquario == idAquario);

//     if (indice >= 0) {
//         alertas[indice] = { idAquario, temp, grauDeAviso, grauDeAvisoCor }
//     } else {
//         alertas.push({ idAquario, temp, grauDeAviso, grauDeAvisoCor });
//     }

//     exibirCards();
// }

// function removerAlerta(idAquario) {
//     alertas = alertas.filter(item => item.idAquario != idAquario);
//     exibirCards();
// }

// function exibirCards() {
//     alerta.innerHTML = '';

//     for (var i = 0; i < alertas.length; i++) {
//         var mensagem = alertas[i];
//         alerta.innerHTML += transformarEmDiv(mensagem);
//     }
// }

// function transformarEmDiv({ idAquario, temp, grauDeAviso, grauDeAvisoCor }) {

//     var descricao = JSON.parse(sessionStorage.AQUARIOS).find(item => item.id == idAquario).descricao;
//     return `
//     <div class="mensagem-alarme">
//         <div class="informacao">
//             <div class="${grauDeAvisoCor}">&#12644;</div>
//             <h3>${descricao} está em estado de ${grauDeAviso}!</h3>
//             <small>Temperatura capturada: ${temp}°C.</small>
//         </div>
//         <div class="alarme-sino"></div>
//     </div>
//     `;
// }

// function atualizacaoPeriodica() {
//     JSON.parse(sessionStorage.AQUARIOS).forEach(item => {
//         obterdados(item.id)
//     });
//     setTimeout(atualizacaoPeriodica, 5000);
// }
