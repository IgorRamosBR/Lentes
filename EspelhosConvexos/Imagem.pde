class Imagem { 
  float xpos;
  float ypos;
  float largura;
  float altura;
  public static final String IMAGEM_TIPO_INVERTIDA = "INVERTIDA";
  
  private float xposTriangulo;
  private float yposTriangulo;
  private float centerPosTriangulo;
  private float larguraTriangulo;
  private float alturaQuadrado;
  private float larguraQuadrado;
  
  Imagem(float xpos, float ypos, float largura, float altura) {
    this.xpos = xpos - 5;
    this.ypos = ypos;
    this.largura = largura;
    this.altura = altura;
    alturaQuadrado = ypos - altura + 10;
    larguraQuadrado = this.xpos + largura - 10;
    xposTriangulo = xpos - 10; 
    yposTriangulo = ypos - altura;
    centerPosTriangulo = xpos;
    larguraTriangulo = xposTriangulo + largura;
    
    desenhaQuadrado();
    desenhaTriangulo();
  }
  
  Imagem(float xpos, float ypos, float largura, float altura, String tipo) {
    this.xpos = xpos - 5;
    this.ypos = ypos;
    this.largura = largura;
    this.altura = altura;
    alturaQuadrado = ypos + altura - 10;
    larguraQuadrado = xpos + largura - 15;
    xposTriangulo = xpos - 10; 
    yposTriangulo = ypos + altura;
    centerPosTriangulo = xposTriangulo + 10;
    larguraTriangulo = xposTriangulo + largura;
    
    desenhaQuadrado();
    desenhaTriangulo();
  }
  
  void desenhaTriangulo() {
    if(altura < 0)
      triangle(xposTriangulo, alturaQuadrado + 20,  centerPosTriangulo, yposTriangulo, larguraTriangulo, alturaQuadrado + 20);
    else
      triangle(xposTriangulo, alturaQuadrado,  centerPosTriangulo, yposTriangulo, larguraTriangulo, alturaQuadrado);
    //triangle(195, 350, 205, 340, 215, 350);
  }
  
  void desenhaQuadrado() {
    if(altura < 0)
      quad(xpos, ypos, xpos, alturaQuadrado + 20, larguraQuadrado, alturaQuadrado + 20, larguraQuadrado, ypos);
    else
      quad(xpos, ypos, xpos, alturaQuadrado, larguraQuadrado, alturaQuadrado, larguraQuadrado, ypos);
    //quad(210, 400, 200, 400, 200,350, 210, 350);
  }
  
  
}