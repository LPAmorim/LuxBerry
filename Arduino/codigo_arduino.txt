// Definição de pino e variáveis
// Declaração da porta analógica como A5
int ldr_pin = A5;
// Variável para armazenar a leitura do sensor LDR
int ldr_read = 0;
// Tensão do circuito
float vin = 5.00;
// Valor correspondente a 1 unidade do ADC e resistor fixo (10kΩ)
float valor_ADC = 0.00488758, r_ohms = 10000;


void setup() {
  Serial.begin(9600); //E a frequência que o "Arduino está se comunicando" 
}

void loop() {
  // Função para verificar se o sensro está trazendo números
  if(isnan(ldr_read)){
    Serial.println("Erro ao ler o sensor");

  }

  else{
      // Leitura do sensor LDR
    ldr_read = analogRead(ldr_pin);
      // Conversão de leitura para tensão e resistência
    float vout = valor_ADC * ldr_read;
    float res_ldr = (r_ohms * (vin - vout))/vout; //calcula a resistência do LDR (res_ldr) com base na leitura de tensão do sensor.
    float lux = 500/(res_ldr/1000); // Cálculo de luminosidade

 

    // Impressão dos valores lidos e processados
    Serial.print(ldr_read);
    Serial.print(" Vout: ");
    Serial.print(vout);
    Serial.print(" R_ldr: ");
    Serial.print(res_ldr);
    Serial.print(" Lux: ");
    Serial.print(lux);
    Serial.println(ldr_read > 750 ? " Claro" : " Escuro");

  }

  delay(2000); // Aguarda 2 segundos antes da próxima leitura
}