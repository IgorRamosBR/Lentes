float posicaoPlano = 500;
float posicaoLente = 500;
float distanciaFocal = 50;
float posicaoFL = posicaoLente - distanciaFocal;
float posicaoF = posicaoLente + distanciaFocal;
float posicaoAntePrincipal = posicaoLente + 2 * distanciaFocal;
float posicaoAnteL = posicaoLente - 2 * distanciaFocal;

int lente = 1;
String nomeLente;

float posicaoImagem = posicaoLente - 2.5 * distanciaFocal;
float alturaImagem = 60;

float coefLinearRaioCentro = 0;
float xFinalRaioCentro = 0;
float coefLinearParalelo = 0;
float xFinalRaioParelelo = 0;

float coefLinearRaioDeFocoParaLente = 0;
float xFinalRaioDeFocoParaLente = 0;

float xImagemFormada = 0;
float yImagemFormada = 0;

float yFinalRaios = 900;
float yFinalRaioDeFocoParaLente = 350;

Imagem imagem;

void setup() {
  size(1100,900);
  background(0,0,0);
  
  noLoop();
}

void draw() {
  background(0,0,0);
  
  init();
  desenhaInformacoes();
  
  desenhaPlano();
  desenhaImagem(posicaoImagem, posicaoPlano, 20, alturaImagem);
  desenhaRaios();
  desenhaImagemFormada();
  desenhaPropriedadesDaImagem();
  
}
void init() {
  posicaoFL = posicaoLente - distanciaFocal;
  posicaoF = posicaoLente + distanciaFocal;
  posicaoAntePrincipal = posicaoLente + 2 * distanciaFocal;
  posicaoAnteL = posicaoLente - 2 * distanciaFocal;
  desenhaLente(lente);
}

void desenhaInformacoes() {
  textSize(30);
  text("Lentes Divergentes " + nomeLente, 60, 50);
  textSize(18);
  text("Trocar lente: L \nMover Imagem: ← →\nAlterar tamanho: ↑ ↓\nModificar Raio de Curvatura: + -", 60, 100);
}

void desenhaPlano() { 
  
  //PLANO
  stroke(255, 255,255);
  line(50,posicaoPlano, 1050, posicaoPlano);
  
  //FOCO'
  line(posicaoFL , posicaoPlano - 10, posicaoFL, posicaoPlano + 10); 
  textSize(14);
  text("F'", posicaoFL - 15, posicaoPlano + 15);
  
  //AP'
  line(posicaoAnteL, posicaoPlano - 10, posicaoAnteL, posicaoPlano + 10);
  text("AP'",  posicaoAnteL - 25, posicaoPlano + 15);
  
  //LENTE
  //line(posicaoLente, posicaoPlano - 150, posicaoLente, posicaoPlano + 150);
  
  //FOCO
  line(posicaoF , posicaoPlano - 10, posicaoF, posicaoPlano + 10); 
  textSize(14);
  text("F", posicaoF - 15, posicaoPlano + 15);
  
  //AP
  line(posicaoAntePrincipal, posicaoPlano - 10, posicaoAntePrincipal, posicaoPlano + 10);
  text("AP",  posicaoAntePrincipal - 25, posicaoPlano + 15);
}

void desenhaLente(int lente) {
  noFill();
  stroke(255,255,255);
  textSize(24);
  switch(lente) {
    case 1: 
      nomeLente = "Bicôncava";
      line(posicaoLente - 40, posicaoPlano - 150, posicaoPlano + 40,posicaoPlano - 150);
      arc(posicaoLente + 40, posicaoPlano, 50*1.2, 300, PI/2, 3*PI/2);
      arc(posicaoLente - 40, posicaoPlano, 50*1.2, 300, -PI/2, PI/2);
      line(posicaoLente - 40, posicaoPlano + 150, posicaoPlano + 40,posicaoPlano + 150);
      break;
   case 2:
      nomeLente = "Plano-Côncava";
      line(posicaoLente - 20, posicaoPlano - 150, posicaoPlano - 20,posicaoPlano + 150);
      line(posicaoLente - 20, posicaoPlano - 150, posicaoPlano + 40,posicaoPlano - 150);
      arc(posicaoLente + 40, posicaoPlano, 50*1.2, 300, PI/2, 3*PI/2);
      line(posicaoLente - 20, posicaoPlano + 150, posicaoPlano + 40,posicaoPlano + 150);
      break;
   case 3: 
      nomeLente = "Côncavo-convexa";
      arc(posicaoLente + 20, posicaoPlano, 50*1.2, 300, PI/2, 3*PI/2);
      arc(posicaoLente + 20, posicaoPlano, 50*0.5, 300, PI/2, 3*PI/2);
      break;
  }
}

void desenhaImagem(float posX, float posY, float largura, float altura) {
  fill(255);
  imagem = new Imagem(posX, posY, largura, altura);
}

void desenhaRaios() {
  line(posicaoImagem, posicaoPlano - alturaImagem, posicaoLente, posicaoPlano - alturaImagem);
  
  calculaRaioCentro();
  
  //calculaRaioParalelo();
  calculaRaioDeFocoParaLente();
  
}

void desenhaImagemFormada() {
  if(posicaoImagem > posicaoF)
    calculaImagemFormada(0);
  else 
    calculaImagemFormada(yFinalRaios);
  desenhaImagemInvertida(xImagemFormada, yImagemFormada - posicaoPlano);
}

float calculaPontoXquePassaPorPontoQualquer(float x1, float y1, float coeficienteLinear, float posY) {
                // y - y1 + mx1 / m
  float xFinal = (posY - y1 + coeficienteLinear * x1) / coeficienteLinear;
  
  return xFinal;
}
void calculaRaioCentro() {
  coefLinearRaioCentro = alturaImagem / (posicaoLente - posicaoImagem);
  xFinalRaioCentro = calculaPontoXquePassaPorPontoQualquer(posicaoLente, posicaoPlano, coefLinearRaioCentro, yFinalRaios);
  
  line(posicaoImagem, posicaoPlano - alturaImagem, xFinalRaioCentro, yFinalRaios);
  
  if(posicaoImagem > posicaoF){
    float xFinalRaioCentroDepoisFoco = xFinalRaioCentro = calculaPontoXquePassaPorPontoQualquer(posicaoLente, posicaoPlano, coefLinearRaioCentro, 0);
    line(posicaoImagem, posicaoPlano - alturaImagem, xFinalRaioCentroDepoisFoco, 0);
  }
}

void calculaRaioParalelo() {
  coefLinearParalelo =  alturaImagem /(posicaoFL - posicaoLente) ;
  xFinalRaioParelelo = calculaPontoXquePassaPorPontoQualquer(posicaoFL, posicaoPlano, coefLinearParalelo, yFinalRaios );
  line(posicaoLente,posicaoPlano -  alturaImagem, xFinalRaioParelelo, yFinalRaios);
  
  if(posicaoImagem > posicaoF){
    float xFinalRaioParaleloDepoisFoco = calculaPontoXquePassaPorPontoQualquer(posicaoFL, posicaoPlano, coefLinearParalelo, 0 );
    line(posicaoLente,posicaoPlano -  alturaImagem, xFinalRaioParaleloDepoisFoco, 0);
  }
}

void calculaRaioDeFocoParaLente() {
    coefLinearRaioDeFocoParaLente = -alturaImagem /(posicaoLente  - posicaoFL)  ;
    xFinalRaioDeFocoParaLente = calculaPontoXquePassaPorPontoQualquer(posicaoLente, posicaoPlano - alturaImagem, coefLinearRaioDeFocoParaLente, yFinalRaioDeFocoParaLente );
    println(coefLinearRaioDeFocoParaLente);
    println(xFinalRaioDeFocoParaLente);
    line(posicaoFL ,posicaoPlano, xFinalRaioDeFocoParaLente, yFinalRaioDeFocoParaLente);
  
}

void calculaImagemFormada(float posY) {
  // (-m2x2 + y2 + mx1 - y1)/ (m - m2)
  xImagemFormada = (-coefLinearRaioDeFocoParaLente * posicaoLente + (posicaoPlano -  alturaImagem) + coefLinearRaioCentro * xFinalRaioCentro - posY) / (coefLinearRaioCentro - coefLinearRaioDeFocoParaLente);  
  yImagemFormada = coefLinearRaioDeFocoParaLente*xImagemFormada - coefLinearRaioDeFocoParaLente * posicaoLente + (posicaoPlano - alturaImagem);
}

void desenhaImagemInvertida(float posX, float altura) {
 
  imagem = new Imagem(posX, posicaoPlano, 20, altura, Imagem.IMAGEM_TIPO_INVERTIDA);
}

void desenhaPropriedadesDaImagem() {
  textSize(24);
  text("Tamanho: " + abs(yImagemFormada - posicaoPlano), 800, 50);
  text("Natureza: Virtual", 800, 100);
  text("Orientação: Direita", 800, 200);
  text("Dimensão: Menor", 800, 150);
    

}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
        if(posicaoImagem > 200)
          posicaoImagem -= 5;

      } 
    
    if (keyCode == RIGHT) {
        if (posicaoImagem < 495)
          posicaoImagem += 5;
      } 
  
    if(keyCode == UP) {
       if(alturaImagem < 80) 
          alturaImagem += 5;
          println(alturaImagem);
    }
    if(keyCode == DOWN) {
      if(alturaImagem > 30)
       alturaImagem -= 5;
    }
  }
  if (key == '+') {
    if(distanciaFocal < 100)
      distanciaFocal += 10;
    println(distanciaFocal);
  }
  if (key == '-') {
    if(distanciaFocal > 20)
      distanciaFocal -= 10;
    println(distanciaFocal);
  }
  if (key == 'l') {
  lente++;
  if(lente > 3)
    lente = 1;
  }
  redraw();
}