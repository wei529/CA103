package com.coursereport.model;

import java.util.List;

public interface CourseReportDAO_interface {
	public void add(CourseReportVO courseReportVO);

	public void updateCourrep_Status(String courrep_status, String courrepo_id, String reply_mgr_id);// 伯誼建議用courrepo_id篩選改status
				
	public CourseReportVO findByPK(String courrepo_id);

	public List<CourseReportVO> findByCourIdplusStatus(String cour_id, String courrep_status);

	public List<CourseReportVO> getAll();
	
	public List<CourseReportVO> findByCourStatus(String courrep_status);

	public List<CourseReportVO> findSolvedCours();
}
