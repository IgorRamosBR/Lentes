float posicaoPlano = 500;
float posicaoEspelho = 500;
float distanciaFocal = 0;
float posicaoFL = posicaoEspelho + distanciaFocal;
float posicaoF = posicaoEspelho - distanciaFocal;
float posicaoCentro = posicaoEspelho - 2 * distanciaFocal;
float posicaoCentroL = posicaoEspelho + 2 * distanciaFocal;
float raioCurvatura = 150;

float posicaoImagem = 0;
float alturaImagem = 60;
float posicaoImagemFormada = 0;
float alturaImagemFormada = 0;

float xRaioParalelo = 0;
float coefLinearRaioCentro = 0;
float xFinalRaioCentro = 0;
float coefLinearFoco = 0;
float xFinalRaioFoco = 0;
float cateto = 0;
float catetoFoco = 0;

float xImagemFormada = 0;
float yImagemFormada = 0;

Imagem imagem;

void setup() {
  size(1100,900);
  background(0,0,0);
  distanciaFocal = raioCurvatura / 2;
  posicaoImagem = posicaoEspelho - raioCurvatura;
  noLoop();
}

void draw() {
  background(0,0,0);
  textSize(36);
  
  init();
  desenhaInformacoes();


  desenhaPlano();
  desenhaImagem(posicaoImagem, posicaoPlano, 20, alturaImagem);
  calculaPosicaoImagemFormada();
  calculaAlturaImagemFormada();
  desenhaRaios();
  desenhaImagemFormada();
  desenhaPropriedadesDaImagem();
  
}
void init() {
  raioCurvatura = 2*distanciaFocal;
  posicaoFL = posicaoEspelho + distanciaFocal;
  posicaoF = posicaoEspelho - distanciaFocal;
  posicaoCentro = posicaoEspelho - raioCurvatura;
  posicaoCentroL = posicaoEspelho + raioCurvatura;

}

void desenhaInformacoes() {
  textSize(30);
  text("Espelhos Concavos", 60, 50);
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
  arc(posicaoEspelho - raioCurvatura / 3 + 2 , posicaoPlano, raioCurvatura*2 /3, raioCurvatura*4, -HALF_PI, HALF_PI);
  
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

void calculaPosicaoImagemFormada() {
  float p = posicaoEspelho - posicaoImagem;
  posicaoImagemFormada =posicaoEspelho - (distanciaFocal * p / (p - distanciaFocal));  
}

void calculaAlturaImagemFormada() {
  alturaImagemFormada = -posicaoImagemFormada * alturaImagem / posicaoImagem;
  
}

void desenhaRaios() {
  
  calculaRaioParelelo();
  calculaRaioCentro();
  calculaRaioPartindoDoCentro();
  calculaRaioPassandoPeloFoco();
  calculaPosicaoImagemFormada();
//calculaAlturaImagemFormada();
  //calculaRaioDaImagemProFoco();
}

void calculaRaioParelelo() { 
  line(posicaoImagem, posicaoPlano - alturaImagem, posicaoEspelho,posicaoPlano - alturaImagem);
}

void calculaRaioDaImagemProFoco() {
  float coef = alturaImagem / ( posicaoF - posicaoImagem);
  float x =  calculaPontoXquePassaPorPontoQualquer(posicaoF, posicaoPlano, coef, 700);
  line(posicaoImagem, posicaoPlano - alturaImagem, x, 700);  
}


void calculaRaioCentro() {
  coefLinearRaioCentro = -alturaImagem / (posicaoEspelho - posicaoImagem);
  xFinalRaioCentro = calculaPontoXquePassaPorPontoQualquer(posicaoEspelho, posicaoPlano, coefLinearRaioCentro, 500);
  
  line(posicaoImagem, posicaoPlano - alturaImagem, xFinalRaioCentro, 500);
  
}

void calculaRaioPartindoDoCentro() {
  float xFinalRaioPartindoDoCentro = calculaPontoXquePassaPorPontoQualquer(posicaoEspelho, posicaoPlano, coefLinearRaioCentro, 900);
  
  line(posicaoPlano, posicaoPlano , xFinalRaioPartindoDoCentro, 900);
  
  if(posicaoImagem > posicaoF){
    float xFinalRaioCentroDepoisFoco = calculaPontoXquePassaPorPontoQualquer(posicaoEspelho, posicaoPlano, coefLinearRaioCentro, 0);
    line(posicaoEspelho, posicaoPlano, xFinalRaioCentroDepoisFoco, 0);
  }
}

void calculaRaioPassandoPeloFoco() {
  coefLinearFoco = -alturaImagem / (posicaoEspelho - posicaoF);
  //float coefLinear = catetoFoco / alturaImagem;
  //float xFinal = (700 - posicaoPlano) / coefLinear;
  xFinalRaioFoco  = calculaPontoXquePassaPorPontoQualquer(posicaoF, posicaoPlano, coefLinearFoco, 900);
  //println((catetoFoco));
  //line(posicaoF, posicaoPlano - 10, posicaoF + catetoFoco, posicaoPlano - 10);
  line(posicaoEspelho, posicaoPlano - alturaImagem, xFinalRaioFoco, 900);
  //desenhaImagemInvertida(posicaoImagem, alturaImagem);
  
  if(posicaoImagem > posicaoF){
    float xFinalRaioCentroDepoisFoco = calculaPontoXquePassaPorPontoQualquer(posicaoF, posicaoPlano , coefLinearFoco, 0);
    line(posicaoEspelho, posicaoPlano - alturaImagem, xFinalRaioCentroDepoisFoco, 0);
  }
  
}

void desenhaImagemFormada() {
    calculaImagemFormada();
    println(xImagemFormada);
    println(yImagemFormada);
  
    //desenhaImagem(xImagemFormada, posicaoPlano, 20, posicaoPlano - yImagemFormada);
    desenhaImagemInvertida(xImagemFormada, posicaoPlano - yImagemFormada);

}

void calculaImagemFormada() {
  // (-m2x2 + y2 + mx1 - y1)/ (m - m2)
  xImagemFormada = (-coefLinearFoco * posicaoF + posicaoPlano + coefLinearRaioCentro * posicaoEspelho - posicaoPlano) / (coefLinearRaioCentro - coefLinearFoco);
  // (mx1 - mx + y1
  yImagemFormada = coefLinearFoco*posicaoF - coefLinearFoco * xImagemFormada + posicaoPlano;
}
void desenhaImagemInvertida(float posX, float altura) {
 
  imagem = new Imagem(posX, posicaoPlano, 20, altura, Imagem.IMAGEM_TIPO_INVERTIDA);
}

float calculaPontoXquePassaPorPontoQualquer(float x1, float y1, float coeficienteLinear, float posY) {
                // y - y1 + mx1 / m
  float xFinal = (posY - y1 + coeficienteLinear * x1) / coeficienteLinear;
  
  return xFinal;
}

void desenhaPropriedadesDaImagem() {
  textSize(24);
  text("Tamanho: " + abs(yImagemFormada - posicaoPlano), 800, 50);
  if(posicaoImagem > posicaoF) {
    text("Natureza: Virtual", 800, 100);
    text("Orientação: Direita", 800, 200);
  }
  else if(posicaoImagem < posicaoF) {
    text("Natureza: Real", 800, 100);
    text("Orientação: Invertida", 800, 200);  
  }
  else 
    text("Natureza: Imprópria", 800, 100);
    
  if(alturaImagem >abs(posicaoPlano - yImagemFormada))
    text("Dimensão: Menor", 800, 150);
  else if(alturaImagem < abs(posicaoPlano - yImagemFormada))
    text("Dimensão: Maior", 800, 150);
  else 
    text("Dimensão: Igual", 800, 150);
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
        println(posicaoImagem);
        if(posicaoImagem > 200)
          posicaoImagem -= 5;
      } 
    
    if (keyCode == RIGHT) {
        if (posicaoImagem < 470)
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
    if(distanciaFocal < 200)
      distanciaFocal += 10;
    println(distanciaFocal);
  }
  if (key == '-') {
    if(distanciaFocal > 100)
      distanciaFocal -= 10;
    println(distanciaFocal);
  }
  redraw();
}