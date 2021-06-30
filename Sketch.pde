PFont f;
String target;
int popMax;
float mutationRate;
Population population;
void setup() {
  size(600, 600);
  f = createFont("Courier", 32, true);
  target = "To be or not to be.";
  popMax = 150;
  mutationRate = 0.01;
  population = new Population(target, mutationRate, popMax);
}

void draw() {
  
  population.naturalSelection();
  
  population.generate();
  
  population.calcFitness();
  displayInfo();
  
  if (population.finished) {
    println(millis()/1000.0);
    noLoop();
  }
}

void displayInfo() {
  background(255);
  
  String answer = population.getBest();
  textFont(f);
  textAlign(LEFT);
  fill(0);
  
  textSize(16);
  text("Best Phrase:", 20, 30);
  textSize(32);
  text(answer, 20, 75);
  
  textSize(12);
  text("Total generations: " + population.getGenerations(), 20, 140);
  text("Avarege fitness: " + nf(population.getAvaregeFitness(), 0, 2), 20, 155);
  text("Total population: " + popMax, 20, 170);
  text("Mutation Rate: " + int(mutationRate * 100) + "%", 20, 185);
  
  textSize(10);
  text("All Phrases:\n" + population.allPhrases(), 450, 10);
}
