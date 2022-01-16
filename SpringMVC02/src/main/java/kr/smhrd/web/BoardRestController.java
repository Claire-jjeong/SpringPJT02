package kr.smhrd.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.board.domain.Board;
import kr.board.mapper.BoardMapper;
import kr.board.service.BoardService;

@RestController //클라이언트에게 바로 응답해 줄 수 있는 것, Responsebody역할 함
public class BoardRestController { //OpenAPI - JSON

	@Autowired
	private BoardService service;
	
	@RequestMapping("/boardListAjax.do")
	public List<Board> boardListAjax() {
		List<Board> list= service.boardListAjax();
		//여기서 json data format 으로 응답 해야 함
		// List<Board>를 -> Gson API이용 -> String(JSON) 형태로 변환
		return list; //List<Board> -> jakson -> String(JSON)
		//responsebody로 객체를 반환하게 되면 jackson데이터 바인드에 의해서 json포맷으로 변경 됨 (배열형태)	
	}
	@RequestMapping("/boardInsertAjax.do")
	public void boardInsertAjax(Board vo) {
		service.boardInsertAjax(vo);
	}
	@RequestMapping("/boardContentUpdateAjax.do")
	public void boardContentUpdateAjax(Board vo) {
			//요청이 왔던 곳으로 다시 응답이 가야하기 때문 (jsp가 아닌 ajax로 감)
		service.boardContentUpdateAjax(vo);
	}
	@RequestMapping("/boardDeleteAjax.do") //post:postmapping
	public void boardDeleteAjax(int idx) {
		service.boardDeleteAjax(idx);
	}
	@RequestMapping("/boardTWUpdateAjax.do")
	public void boardTWUpdateAjax(Board vo) {
		service.boardTWUpdateAjax(vo);
	}
}
