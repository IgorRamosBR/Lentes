float posicaoPlano = 500;
float posicaoEspelho = 500;
float distanciaFocal = 0;
float posicaoFL = posicaoEspelho + distanciaFocal;
float posicaoF = posicaoEspelho - distanciaFocal;
float posicaoCentro = posicaoEspelho - 2 * distanciaFocal;
float posicaoCentroL = posicaoEspelho + 2 * distanciaFocal;
float raioCurvatura = 150;

int lente = 1;
String nomeLente;

float posicaoImagem = 0;
float alturaImagem = 60;

float xRaioParalelo = 0;
float cateto = 0;
float catetoFoco = 0;
float coefLinearRaioCentro = 0;
float coefLinearPassandoPeloFoco = 0;
float xFinalRaioCentro = 0;
float xFinalPassandoPeloFoco = 0;

float xImagemFormada = 0;
float yImagemFormada = 0;

Imagem imagem;

void setup() {
  size(1100,900);
  background(0,0,0);
  posicaoImagem = posicaoEspelho + 1.5 * raioCurvatura;
  distanciaFocal = raioCurvatura / 2;   
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
  posicaoFL = posicaoEspelho + distanciaFocal;
  posicaoF = posicaoEspelho - distanciaFocal;
  posicaoCentro = posicaoEspelho - 2*distanciaFocal;
  posicaoCentroL = posicaoEspelho + 2*distanciaFocal;
  raioCurvatura = 2*distanciaFocal;

}

void desenhaInformacoes() {
  textSize(30);
  text("Espelhos Convexos", 60, 50);
  textSize(18);
  text("Mover Imagem: ← →\nAlterar tamanho: ↑ ↓\nModificar Raio de Curvatura: + -", 60, 100);
}

void desenhaPlano() { 
  
  //PLANO
  stroke(255, 255,255);
  line(50,posicaoPlano, 1050, posicaoPlano);
  
  //FOCO'
  line(posicaoFL , posicaoPlano - 10, posicaoFL, posicaoPlano + 10); 
  textSize(14);
  text("F'", posicaoFL - 15, posicaoPlano + 15);
  
  //C'
  line(posicaoCentroL, posicaoPlano - 10, posicaoCentroL, posicaoPlano + 10);
  text("C'",  posicaoCentroL - 15, posicaoPlano + 15);
  
  //LENTE
  //line(posicaoEspelho, posicaoPlano - 150, posicaoEspelho, posicaoPlano + 150);
  noFill();
  arc(posicaoEspelho - raioCurvatura, posicaoPlano, raioCurvatura*2, raioCurvatura*2, -HALF_PI, HALF_PI);
  
  //FOCO
  line(posicaoF , posicaoPlano - 10, posicaoF, posicaoPlano + 10); 
  textSize(14);
  text("F", posicaoF - 15, posicaoPlano + 15);
  
  //C
  line(posicaoCentro, posicaoPlano - 10, posicaoCentro, posicaoPlano + 10);
  text("C",  posicaoCentro - 15, posicaoPlano + 15);
}

void desenhaImagem(float posX, float posY, float largura, float altura) {
  fill(255,255,255);
  imagem = new Imagem(posX, posY, largura, altura);
}

void desenhaRaios() {
  
  calculaRaioParelelo();
  calculaRaioParaCentro();
  calculaRaioPassandoPeloFoco();
  //calculaRaioParalelo();
  
}
void calculaRaioParelelo() {
  cateto = sqrt(sq(raioCurvatura) - sq(alturaImagem));
  catetoFoco = cateto + posicaoCentro - posicaoF;
  xRaioParalelo = cateto + posicaoCentro;
  
  line(posicaoImagem, posicaoPlano - alturaImagem, xRaioParalelo,posicaoPlano - alturaImagem);
}

void calculaRaioParaCentro() {
  coefLinearRaioCentro = -alturaImagem /catetoFoco ;
  //xFinalRaioCentro = (500 - 440 + coefLinearRaioCentro * xRaioParalelo) / coefLinearRaioCentro;
  xFinalRaioCentro = calculaPontoXquePassaPorPontoQualquer(xRaioParalelo, posicaoPlano - alturaImagem, coefLinearRaioCentro, 500);

  line(xRaioParalelo, posicaoPlano - alturaImagem, xFinalRaioCentro, 500);
}

void calculaRaioPassandoPeloFoco() {
  coefLinearPassandoPeloFoco = -alturaImagem /(posicaoImagem - posicaoCentro);
  xFinalPassandoPeloFoco = calculaPontoXquePassaPorPontoQualquer(posicaoImagem, posicaoPlano - alturaImagem, coefLinearPassandoPeloFoco, posicaoPlano);

  line(posicaoImagem, posicaoPlano - alturaImagem, xFinalPassandoPeloFoco, posicaoPlano);
}

float calculaPontoXquePassaPorPontoQualquer(float x1, float y1, float coeficienteLinear, float posY) {
                // y - y1 + mx1 / m
  float xFinal = (posY - y1 + coeficienteLinear * x1) / coeficienteLinear;
  
  return xFinal;
}

void calculaImagemFormada() {
  xImagemFormada = (-coefLinearPassandoPeloFoco * posicaoImagem + (posicaoPlano - alturaImagem) + coefLinearRaioCentro *xRaioParalelo - (posicaoPlano - alturaImagem)) / (coefLinearRaioCentro - coefLinearPassandoPeloFoco);
  yImagemFormada = coefLinearPassandoPeloFoco * xImagemFormada - coefLinearPassandoPeloFoco * posicaoImagem + posicaoPlano - alturaImagem;
}

void desenhaImagemFormada() {
  calculaImagemFormada();
  desenhaImagem(xImagemFormada, posicaoPlano, 20, posicaoPlano - yImagemFormada);
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
        println(posicaoImagem);
        if(posicaoImagem > 505)
          posicaoImagem -= 5;
      } 
    
    if (keyCode == RIGHT) {
        if (posicaoImagem < 800)
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
    if(distanciaFocal < 150)
      distanciaFocal += 10;
    println(raioCurvatura);
  }
  if (key == '-') {
    if(distanciaFocal > 50)
      distanciaFocal -= 10;
    println(raioCurvatura);
  }
  redraw();
}