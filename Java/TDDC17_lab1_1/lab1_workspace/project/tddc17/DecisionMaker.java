package tddc17;
/*
 *Class for making decisions depending on the surrounding 
 */
import java.util.*;


public class DecisionMaker {
	private int [] surroundings;
	private int[][] map;

	private Random rand = new Random();
	private Boolean bump;
	private Boolean deadEnd;
	private final int ACTION_NONE 			= 0;
	private final int ACTION_MOVE_FORWARD 	= 1;
	private final int ACTION_TURN_RIGHT 	= 2;
	private final int ACTION_TURN_LEFT 		= 3;
	private final int ACTION_SUCK	 		= 4;
	private final int [] dodgeObstacle = new int[] {ACTION_TURN_RIGHT,ACTION_MOVE_FORWARD,ACTION_TURN_LEFT};
	private final int [] uTurn = new int[] {ACTION_TURN_RIGHT,ACTION_TURN_RIGHT};
	private final int[] turnLeft= new int[] {ACTION_TURN_LEFT,ACTION_MOVE_FORWARD};
	private final int[] turnRight= new int[] {ACTION_TURN_RIGHT,ACTION_MOVE_FORWARD};
	private final int[] goForward= new int[] {ACTION_MOVE_FORWARD};
	
	DecisionMaker(){
		this.surroundings = new int [] {0,0,0,0};
	}
	public void updateSurroundings(int[] surroundings,int[][] map,Boolean bump, int xpos, int ypos, int dir){
		this.surroundings = surroundings;
		this.bump=bump;
		this.map=map;
		if(bump && !hasMultiplePaths()){
			this.deadEnd = true;
		}
	}
	
	// Interprets the surrounding and returns an appropriate action 
	public int [] getDecision(){
		
		//If we have unexplored squares nearby, explore them.
		if(hasMultiplePaths()){
			deadEnd=false;
		}
		if(surroundings[3]==0){
			return turnLeft;
		}
		else if(surroundings[0]==0){
			return goForward;
		}
		else if(surroundings[1]==0){
			return turnRight;
		}
		else if(surroundings[2]==0){
			return uTurn;
		}
		else if(!deadEnd && bump){
			deadEnd=true;
			return uTurn;
		}
		else if(deadEnd){
			int tmp = rand.nextInt(2);
			if(tmp==0){
				
				if(surroundings[1]!=1){
					return turnRight;
				}
				else if(surroundings[0]!=1){
					return goForward;
				}
				else if(surroundings[3]!=1){
					 return turnLeft;
				}
				
			}
			else{
				if(surroundings[0]!=1){
					return goForward;
				}
				else if(surroundings[3]!=1){
					 return turnLeft;
				}
				else if(surroundings[1]!=1){
					return turnRight;
				}
				
			}
			if(bump){
				tmp = rand.nextInt(2);
				if(tmp==1){
					return turnRight;
				}
				else{
					return turnLeft;
				}
			}
			
		}
		else{
			return goForward;
		}
		return goForward;
	}
	
	// Checks if the agent is surrounded by multiples paths 
	public Boolean hasMultiplePaths(){
		int counter = 0;
		if(surroundings[3]==0){
			counter++;
		}
		if(surroundings[0]==0){
			counter++;
		}
		if(surroundings[1]==0){
			counter++;
		}
		if(surroundings[2]==0){
			counter++;
		}
		if(counter>1){
			return true;
		}
		else{
			return false;
		}
	}
	
	// is there any unexplored squares left on the map
	public Boolean isUnexplored(){
		for(int i=1;i<18;i++){
			for(int j=1;j<18;j++){
				if(map[i][j]==0){
					if(map[i+1][j]!=1 && map[i-1][j]!=1 && map[i][j+1]!=1 && map[i][j-1]!=1){
						return true;
					}
				}
			}
		}
		return false;
	}

}