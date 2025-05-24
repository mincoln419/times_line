package org.mermer.todoapi.entity;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.processing.Generated;
import com.querydsl.core.types.Path;
import com.querydsl.core.types.dsl.PathInits;


/**
 * QTimeUser is a Querydsl query type for TimeUser
 */
@Generated("com.querydsl.codegen.DefaultEntitySerializer")
public class QTimeUser extends EntityPathBase<TimeUser> {

    private static final long serialVersionUID = -492071355L;

    public static final QTimeUser timeUser = new QTimeUser("timeUser");

    public final StringPath cd = createString("cd");

    public final StringPath ci = createString("ci");

    public final StringPath email = createString("email");

    public final StringPath hp = createString("hp");

    public final StringPath id = createString("id");

    public final DateTimePath<java.time.LocalDateTime> lastSignAt = createDateTime("lastSignAt", java.time.LocalDateTime.class);

    public final StringPath password = createString("password");

    public final ListPath<SignInHistory, QSignInHistory> signInHistories = this.<SignInHistory, QSignInHistory>createList("signInHistories", SignInHistory.class, QSignInHistory.class, PathInits.DIRECT2);

    public final DateTimePath<java.time.LocalDateTime> signUpAt = createDateTime("signUpAt", java.time.LocalDateTime.class);

    public final StringPath userName = createString("userName");

    public QTimeUser(String variable) {
        super(TimeUser.class, forVariable(variable));
    }

    public QTimeUser(Path<? extends TimeUser> path) {
        super(path.getType(), path.getMetadata());
    }

    public QTimeUser(PathMetadata metadata) {
        super(TimeUser.class, metadata);
    }

}

