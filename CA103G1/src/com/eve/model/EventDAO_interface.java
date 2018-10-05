package com.eve.model;

import java.util.List;

public interface EventDAO_interface {
    public void insert(EventVO eventVO);
    public void update(EventVO eventVO);
    public void updatePhoto(byte[] eve_photo,String eve_id);
    public void update_status(String eve_id , String eve_status);
    public EventVO findByPrimaryKey(String eve_id);
    public List<EventVO> getAll();
    public List<EventVO> getEvesByMem(String mem_id);
    public List<EventVO> getReviewEves();
    public List<EventVO> getAllinViewPage();
  
    
//    public void delete(String eve_id);
    //�U�νƦX�d��(�ǤJ�Ѽƫ��AMap)(�^�� List)
//  public List<EmpVO> getAll(Map<String, String[]> map); 

}