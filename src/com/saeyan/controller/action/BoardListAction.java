package com.saeyan.controller.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saeyan.dao.BoardDAO;
import com.saeyan.dto.BoardVO;

public class BoardListAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "/board/boardList.jsp";
		
		BoardDAO bDao = BoardDAO.getInstance();
		
		//page start
		int page = 1;  //첫페이지를 1페이지로 하기 위해
		int limit = 10;  //한 페이지에 보여지는 게시글 개수
		
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		int listcount = bDao.getListCount();  //총 리스트 수를 받아옴
		
		List<BoardVO> boardList = bDao.getBoardList(page, limit);  //리스트를 받아옴
		
		//int maxpage = listcount % limit > 0 ? (listcount / limit + 1) : (listcount / limit);
		int maxpage = (int)((double)listcount/10 + 0.95);
		int startpage = ((int)((double)page/10 + 0.9) - 1) * 10 + 1;  // 1,11,21,31...
		int endpage = startpage + 10 - 1;   // 10,20,30...
		
		if(endpage > maxpage) {
			endpage = maxpage;
		}
		
		//---------------------------------end
		
		//List<BoardVO> boardList = bDao.selectAllBoards();  //전체 페이지 조회
		
		request.setAttribute("page", page);
		request.setAttribute("maxpage", maxpage);
		request.setAttribute("startpage", startpage);
		request.setAttribute("endpage", endpage);
		request.setAttribute("listcount", listcount);
		request.setAttribute("boardList", boardList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);
	}

}
