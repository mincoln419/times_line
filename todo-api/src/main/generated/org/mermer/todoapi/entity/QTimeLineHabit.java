package org.mermer.todoapi.entity;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.processing.Generated;
import com.querydsl.core.types.Path;
import com.querydsl.core.types.dsl.PathInits;


/**
 * QTimeLineHabit is a Querydsl query type for TimeLineHabit
 */
@Generated("com.querydsl.codegen.DefaultEntitySerializer")
public class QTimeLineHabit extends EntityPathBase<TimeLineHabit> {

    private static final long serialVersionUID = 28978086L;

    private static final PathInits INITS = PathInits.DIRECT2;

    public static final QTimeLineHabit timeLineHabit = new QTimeLineHabit("timeLineHabit");

    public final StringPath contents = createString("contents");

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final QTimeUser timeUser;

    public QTimeLineHabit(String variable) {
        this(TimeLineHabit.class, forVariable(variable), INITS);
    }

    public QTimeLineHabit(Path<? extends TimeLineHabit> path) {
        this(path.getType(), path.getMetadata(), PathInits.getFor(path.getMetadata(), INITS));
    }

    public QTimeLineHabit(PathMetadata metadata) {
        this(metadata, PathInits.getFor(metadata, INITS));
    }

    public QTimeLineHabit(PathMetadata metadata, PathInits inits) {
        this(TimeLineHabit.class, metadata, inits);
    }

    public QTimeLineHabit(Class<? extends TimeLineHabit> type, PathMetadata metadata, PathInits inits) {
        super(type, metadata, inits);
        this.timeUser = inits.isInitialized("timeUser") ? new QTimeUser(forProperty("timeUser")) : null;
    }

}

