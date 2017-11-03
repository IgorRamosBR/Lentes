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

float xRaioParalelo = 0;
float cateto = 0;
float catetoFoco = 0;

Imagem imagem;

void setup() {
  size(1100,900);
  background(0,0,0);
  
  noLoop();
}

void draw() {
  background(0,0,0);
  textSize(36);
  text("Espelhos Concavos", 60, 50);
  
  init();
  desenhaPlano();
  desenhaImagem(posicaoImagem, posicaoPlano, 20, alturaImagem);
  desenhaRaios();
  /*desenhaImagemFormada();
  desenhaPropriedadesDaImagem();
  */
}
void init() {
  distanciaFocal = raioCurvatura / 2;
  posicaoFL = posicaoEspelho + distanciaFocal;
  posicaoF = posicaoEspelho - distanciaFocal;
  posicaoCentro = posicaoEspelho - raioCurvatura;
  posicaoCentroL = posicaoEspelho + raioCurvatura;
  posicaoImagem = posicaoEspelho - raioCurvatura;
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
  line(posicaoEspelho, posicaoPlano - 150, posicaoEspelho, posicaoPlano + 150);
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
  line(posicaoImagem, posicaoPlano - alturaImagem, posicaoEspelho, posicaoPlano);
  calculaRaioPartindoDoCentro();
  calculaRaioPassandoPeloFoco();
  //calculaRaioParalelo();
  
}
void calculaRaioParelelo() {
  cateto = sqrt(sq(raioCurvatura) - sq(alturaImagem));
  catetoFoco = cateto + posicaoCentro - posicaoF;
  xRaioParalelo = cateto + posicaoCentro;
  
  line(posicaoImagem, posicaoPlano - alturaImagem, xRaioParalelo,posicaoPlano - alturaImagem);
}

void calculaRaioPartindoDoCentro() {
  //float cateto = sqrt(sq(alturaImagem) + sq(posicao));
  float coefLinear = (posicaoEspelho - posicaoImagem) / alturaImagem;
  float xFinalRaioPartindoDoCentro = calculaPontoXquePassaPorPontoQualquer(posicaoEspelho, posicaoPlano, -coefLinear, 700);
  xFinalRaioPartindoDoCentro = (700 - posicaoEspelho) / coefLinear;
  println((coefLinear));
  println(xFinalRaioPartindoDoCentro);
  
  line(posicaoEspelho, posicaoPlano , xFinalRaioPartindoDoCentro, 700);
}

void calculaRaioPassandoPeloFoco() {
  float coefLinear = alturaImagem / catetoFoco;
  float xFinal = (700 - posicaoPlano) / coefLinear;
  println((coefLinear));
  line(xRaioParalelo, posicaoPlano - alturaImagem, xFinal, 700);
  desenhaImagemInvertida(posicaoImagem, alturaImagem);
  line(posicaoCentro - 20, posicaoPlano, posicaoCentro - 20, posicaoPlano + 60);
}

float calculaPontoXquePassaPorPontoQualquer(float x1, float y1, float coeficienteLinear, float posY) {
                // y - y1 + mx1 / m
  float xFinal = (posY - y1 + coeficienteLinear * x1) / coeficienteLinear;
  
  return xFinal;
}

void desenhaImagemInvertida(float posX, float altura) {
 
  imagem = new Imagem(posX, posicaoPlano, 20, altura, Imagem.IMAGEM_TIPO_INVERTIDA);
}