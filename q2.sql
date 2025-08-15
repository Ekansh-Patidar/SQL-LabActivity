DELIMITER $$

CREATE PROCEDURE GetWatchHistoryBySubscriber(IN sub_id INT)
BEGIN
    SELECT 
        s.Title AS ShowTitle,
        w.WatchTime
    FROM 
        WatchHistory w
    JOIN 
        Shows s ON w.ShowID = s.ShowID
    WHERE 
        w.SubscriberID = sub_id;
END$$

DELIMITER ;
