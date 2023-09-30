package controller;

import hangman.SetRandomWord;
import hangman.Words;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class controller {
    @Autowired
    private SetRandomWord setRandomWord;

    @PostMapping(value = "setRandomWord")
    @ResponseBody
    public String productsForm() {
        return setRandomWord.SetRandomWord();
    }
}
