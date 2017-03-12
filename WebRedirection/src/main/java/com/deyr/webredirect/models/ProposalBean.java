package com.deyr.webredirect.models;

import java.util.ArrayList;
import java.util.List;

public class ProposalBean {
List<Proposal> proposals = new ArrayList<>();

public List<Proposal> getProposals() { 
	return proposals;
}

public void setProposals(List<Proposal> proposals) {
	this.proposals = proposals;
}
}
