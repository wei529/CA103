package com.coach.model;
import java.util.List;

import com.coach.model.CoachDAO_interface;
import com.coach.model.CoachDAO;
import com.coach.model.CoachVO;

public class CoachService {
	
	private CoachDAO_interface dao;

	public CoachService() {
		dao = new CoachDAO();
	}

	public CoachVO addCoach(String mem_id, String coa_text, String coa_status) {

		CoachVO coachVO = new CoachVO();

		coachVO.setMem_id(mem_id);
		coachVO.setCoa_text(coa_text);
		coachVO.setCoa_status(coa_status);
		dao.insert(coachVO);

		return coachVO;
	}

	public CoachVO updateCoach(String coa_id, String mem_id, String coa_text, String coa_status) {

		CoachVO coachVO = new CoachVO();

		coachVO.setCoa_id(coa_id);
		coachVO.setMem_id(mem_id);
		coachVO.setCoa_text(coa_text);
		coachVO.setCoa_status(coa_status);
		dao.insert(coachVO);

		return coachVO;
	}

	public CoachVO getOneCoach(String coach_id) {
		return dao.findByPK(coach_id);
	}

	public List<CoachVO> getAll() {
		return dao.getAll();
	}

}
