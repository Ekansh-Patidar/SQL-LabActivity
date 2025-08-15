DELIMITER $$

CREATE PROCEDURE PrintAllSubscribersWatchHistory()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE sub_id INT;
    DECLARE sub_name VARCHAR(100);

    -- Cursor to select all subscribers
    DECLARE cur CURSOR FOR
        SELECT SubscriberID, SubscriberName
        FROM Subscribers;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO sub_id, sub_name;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Print subscriber name as a header
        SELECT CONCAT('Watch history for: ', sub_name) AS Header;

        -- Call existing procedure to get watch history
        CALL GetWatchHistoryBySubscriber(sub_id);
    END LOOP;

    CLOSE cur;
END$$

DELIMITER ;
