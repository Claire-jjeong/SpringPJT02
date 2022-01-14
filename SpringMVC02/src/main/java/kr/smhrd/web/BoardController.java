package kr.smhrd.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.board.domain.Board;
import kr.board.mapper.BoardMapper;

@Controller //전처리 하기 위한 표현
public class BoardController { 
	
	@Autowired //메모리에 생성된 객체를 자동으로 연결해줌 
	private BoardMapper mapper; //new연산자 이용 시 결합도가 높아져 수정에 용이하지 못함 --> xml수정하고 Autowired를 사용 (DI(Dependency Injection) : 의존성 주입)

	//1. 게시판 리스트를 보여달라는 요청을 받아서 DB에서 가져오는 일
	//HandlerMapping
	@RequestMapping("/") //첫페이지 
	public String main() {
		return "basic";
	}


}
