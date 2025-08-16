DELIMITER $$

CREATE PROCEDURE AddSubscriberIfNotExists(IN subName VARCHAR(100))
BEGIN
    DECLARE existing_count INT;
    DECLARE next_id INT;

    SELECT COUNT(*) 
    INTO existing_count
    FROM Subscribers
    WHERE SubscriberName = subName;

    IF existing_count = 0 THEN
        -- Get the next available ID
        SELECT COALESCE(MAX(SubscriberID), 0) + 1
        INTO next_id
        FROM Subscribers;

        INSERT INTO Subscribers (SubscriberID, SubscriberName, SubscriptionDate)
        VALUES (next_id, subName, CURDATE());

        SELECT CONCAT('Subscriber "', subName, '" has been added with ID ', next_id) AS Result;
    ELSE
        SELECT CONCAT('Subscriber "', subName, '" already exists') AS Result;
    END IF;
END$$

DELIMITER ;