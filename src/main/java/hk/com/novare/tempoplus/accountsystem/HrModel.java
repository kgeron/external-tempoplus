package hk.com.novare.tempoplus.accountsystem;

import java.util.List;


public interface HrModel {

	List<HumanResource> selectAll();
	void addEmployee(HumanResource employee );
	HumanResource search(String searches, String category);

	
}
