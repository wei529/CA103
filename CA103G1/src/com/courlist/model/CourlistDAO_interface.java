package com.courlist.model;
import java.util.*;

public interface CourlistDAO_interface {
	public void insert(CourlistVO courlistVO);
    public void update(CourlistVO courlistVO);
    public void delete(String cour_id);
    public CourlistVO findByPK(String cour_id);
    public List<CourlistVO> getAll();
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<CourlistVO> getAll(Map<String, String[]> map); 
    //ashley
    public List<CourlistVO>getCourlistByCoa_id(String coa_id);
    
  //首頁用
    public List<CourlistVO> getNewCour();
    //首頁用
    public List<CourlistVO> getPopularCour();
    
    //課程檢舉後下架
    public void updateState(String cour_lau,String cour_id);
}
