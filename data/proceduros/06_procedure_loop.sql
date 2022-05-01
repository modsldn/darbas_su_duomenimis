drop procedure if exists LoopDemo;

-- ciklas apibreziamas pavadinimu
-- ciklo viduje apibreziame uzklausas
-- apibreziame ciklo nutraukima nurodant LEAVE
-- sekanciai iteracija iskviesti naudojame ITERATE

/*
[begin_label:] LOOP
    statement_list
END LOOP [end_label]
 */

/*
[label]: LOOP
    ...
    -- terminate the loop
    IF condition THEN
        LEAVE [label];
    END IF;
    ...
END LOOP;
 */

DELIMITER $$
CREATE PROCEDURE LoopDemo()
BEGIN
	DECLARE x  INT;
	DECLARE str  VARCHAR(255);
        
	SET x = 1;
	SET str =  '';
        
	loop_label:  LOOP
		IF  x > 10 THEN 
			LEAVE  loop_label;
		END  IF;
            
		SET  x = x + 1;
		IF  (x mod 2) THEN
			ITERATE  loop_label;
		ELSE
			SET  str = CONCAT(str,x,',');
		END  IF;
	END LOOP;
	SELECT str;
END$$

DELIMITER ;

CALL LoopDemo();