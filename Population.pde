class Population {
  float mutationRate;
  DNA[] population;
  ArrayList<DNA> matingPool;
  String target;
  int generations;
  boolean finished;
  int perfectScore;
  
  Population(String p, float m, int num) {
    mutationRate = m;
    target = p;
    population = new DNA[num];
    for(int i = 0; i < population.length; i++) {
      population[i] = new DNA(target.length());
    }
    calcFitness();
    matingPool = new ArrayList<DNA>();
    finished = false;
    generations = 0;
    
    perfectScore = int(pow(2, target.length()));
  }
  
  void calcFitness(){
    for(int i = 0; i < population.length; i++){
      population[i].fitness(target);
    }
  }
  
  void naturalSelection(){
    matingPool.clear();
    float maxFitness = 0;
    for(int i = 0; i< population.length; i++){
      if(population[i].fitness > maxFitness){
        maxFitness = population[i].fitness;
      }
    }
    
    for(int i = 0; i< population.length; i++){
      float fitness = map(population[i].fitness, 0, maxFitness, 0, 1);
      int n = int(fitness * 100);
      for(int j = 0; j < n; j++){
        matingPool.add(population[i]);
      }
    }
  }
  
  void generate(){
    for(int i = 0; i < population.length; i++) {
      int a = int(random(matingPool.size()));
      int b = int(random(matingPool.size()));
      DNA partnerA = matingPool.get(a);
      DNA partnerB = matingPool.get(b);
      DNA child = partnerA.crossover(partnerB);
      child.mutate(mutationRate);
      population[i] = child;
    }
    
    generations ++;
  }
  
  String getBest() {
    float worldrecord = 0.0f;
    int index = 0;
    for(int i = 0; i < population.length; i++) {
      if (population[i].fitness > worldrecord) {
        index = i;
        worldrecord = population[i].fitness;
      }
    }
    
    if (worldrecord == perfectScore) finished = true;
      return population[index].getPhrase();
  }
  
  boolean finished() {
    return finished;
  }
  
  int getGenerations() {
    return generations;
  }
  
  float getAvaregeFitness() {
    float total = 0;
    for(int i = 0; i < population.length; i++){
      total += population[i].fitness;
    }
    return total/(population.length); 
  }
  
  String allPhrases() {
    String everything = "";
    
    int displayLimit = min(population.length, 50);
    for (int i = 0; i < population.length;i++) {
      everything += population[i].getPhrase() + "\n";
    }
    return everything;
  }
  
}
