
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
var indiceA = 0
function alertar(resposta) {
    for (let i = 0; i < resposta.length; i++) {
        alertaID = resposta[i].idalerta
        if (alertaID != sessionStorage.alertaId) {
            dashboard = document.getElementById("alertas")
            dashboard.innerHTML += `
                <div class="alerta" id="card_alerta${indiceA}" onclick="fechar(${indiceA})">
                    <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" viewBox="0 0 24 24"><rect width="24" height="24" fill="none"/><path fill="red" d="M2.725 21q-.275 0-.5-.137t-.35-.363t-.137-.488t.137-.512l9.25-16q.15-.25.388-.375T12 3t.488.125t.387.375l9.25 16q.15.25.138.513t-.138.487t-.35.363t-.5.137zM12 18q.425 0 .713-.288T13 17t-.288-.712T12 16t-.712.288T11 17t.288.713T12 18m0-3q.425 0 .713-.288T13 14v-3q0-.425-.288-.712T12 10t-.712.288T11 11v3q0 .425.288.713T12 15"/></svg>
                    <div>
                    <p>Alerta para a ${resposta[i].nome} - sensor ${resposta[i].fksensor}</p>
                    <p>${resposta[i].tipo_alerta}</p>
                    <p>${resposta[i].dataFormatada}</p>
                    </div>
                </div>
                `
            sessionStorage.alertaId = alertaID
        }
    }
    indiceA++
}

function fechar(id) {
    cardAlerta = document.getElementById(`card_alerta${id}`)
    cardAlerta.style.display = "none"
}