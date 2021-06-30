class DNA {
  char [] genes;
  float fitness;
  
  //Constructor, makes a random DNA.
  DNA(int num) {
    genes = new char[num];
    for(int i = 0; i < genes.length; i++) {
      genes[i] = (char) random(32, 128);
    }
  }
  
  //Convert to a String character.
  String getPhrase() {
    return new String(genes);
  }
  
  void fitness(String target) {
    int score = 0;
    for(int i = 0; i < genes.length; i++) {
      if( genes[i] == target.charAt(i) ){
        score++;
      }
    }
    fitness = pow(2, score);
  }
  
  //Crossover
  DNA crossover(DNA partner) {
    //A new child!
    DNA child = new DNA(genes.length);
    int midpoint = int(random(genes.length));
    //half from one and half from the other
    for(int i = 0; i < genes.length; i++) {
      if(i > midpoint) child.genes[i] = genes[i];
      else             child.genes[i] = partner.genes[i];
    }
    return child;
   }
   
   //mutation rate. Based on random probability, piks a new random char.
   void mutate(float mutationrate) {
     for(int i = 0; i < genes.length; i++) {
       if( random(1) < mutationrate ) {
         genes[i] = (char) random(32, 128);
       }
     }
   }
   
}
