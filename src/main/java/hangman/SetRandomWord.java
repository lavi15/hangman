package hangman;

import org.springframework.stereotype.Component;

import java.util.Random;

@Component
public class SetRandomWord {

    public String SetRandomWord() {
        Random random = new Random();
        Words[] allWords = Words.values();
        int randomIndex = random.nextInt(allWords.length);
        return allWords[randomIndex].category + "," + allWords[randomIndex].name;
    }
}
